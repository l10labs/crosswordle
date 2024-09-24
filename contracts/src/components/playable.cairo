#[starknet::component]
mod PlayableComponent {
    // Core imports

    use core::debug::PrintTrait;

    // Starknet imports

    use starknet::ContractAddress;
    use starknet::info::{get_caller_address, get_block_timestamp};

    // Dojo imports

    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;

    // Internal imports

    use rpg::constants;
    use rpg::store::{Store, StoreTrait};
    use rpg::models::letter::{Letter, LetterTrait};

    use rpg::models::player::{Player, PlayerTrait, PlayerAssert};
    use rpg::models::dungeon::{Dungeon, DungeonTrait, DungeonAssert};
    use rpg::types::role::Role;
    use rpg::types::mode::Mode;
    use rpg::types::direction::Direction;

    // Errors

    mod errors {}

    // Storage

    #[storage]
    struct Storage {}

    // Events

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<
        TContractState, +HasComponent<TContractState>
    > of InternalTrait<TContractState> {
        fn spawn(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            name: felt252,
            role: u8,
            mode: u8
        ) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);

            // [Effect] Create player
            let player_id: felt252 = get_caller_address().into();
            let time: u64 = get_block_timestamp();
            let mut player = PlayerTrait::new(player_id, name, time, mode.into());

            // [Effect] Player role
            player.enrole(role.into());

            // [Effect] Set player
            store.set_player(player);
        }

        fn move(self: @ComponentState<TContractState>, world: IWorldDispatcher, direction: u8) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let player_id: felt252 = get_caller_address().into();
            let (mut player, dungeon) = store.get_state(player_id);

            // [Check] Player is not dead
            player.assert_not_dead();

            // [Check] Current dungeon is done
            dungeon.assert_is_done();

            // [Effect] Move player
            let (monster, role) = player.move(direction.into());
            let new_dungeon: Dungeon = DungeonTrait::new(dungeon.id, monster, role);

            // [Effect] Update state
            store.set_state(player, new_dungeon);
        }

        fn attack(self: @ComponentState<TContractState>, world: IWorldDispatcher) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let player_id: felt252 = get_caller_address().into();
            let (mut player, mut dungeon) = store.get_state(player_id);

            // [Check] Player is not dead
            player.assert_not_dead();

            // [Check] Current dungeon is not done
            dungeon.assert_not_done();

            // [Effect] Attack
            dungeon.take_damage(player.role.into(), player.damage);

            // [Effect] Defend
            if dungeon.is_done() {
                player.reward(dungeon.get_treasury());
            } else {
                player.take_damage(dungeon.role.into(), dungeon.damage);
            }

            // [Effect] Update state
            store.set_state(player, dungeon);
        }

        fn heal(self: @ComponentState<TContractState>, world: IWorldDispatcher, quantity: u8) {
            // [Setup] Datastore
            let store: Store = StoreTrait::new(world);
            let player_id: felt252 = get_caller_address().into();
            let (mut player, dungeon) = store.get_state(player_id);

            // [Check] Player is not dead
            player.assert_not_dead();

            // [Check] Current dungeon is a shop
            dungeon.assert_is_shop();

            // [Effect] Heal
            player.heal(quantity);

            // [Effect] Update state
            store.set_player(player);
        }

        fn create_letter(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            position: u8,
            value: felt252,
        ) {
            let store: Store = StoreTrait::new(world);
            let player_id = get_caller_address();
            let mut letter = LetterTrait::new_wordle(player_id, position, value);

            store.set_letter(letter);
        }

        fn create_word(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            word: [felt252; 5],
        ) {
            let store: Store = StoreTrait::new(world);
            let player_id = get_caller_address();

            let mut index: u32 = 0;
            while index < 5 {
                let position: u8 = index.try_into().unwrap();
                let mut letter = LetterTrait::new_wordle(player_id, position, word.span()[index].clone());
                store.set_letter(letter);
                let color = LetterTrait::init_color(position);
                store.set_color(color);
                index += 1;
            }
        }

        fn guess_word(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
            word: [felt252; 5],
        ) {
            let store: Store = StoreTrait::new(world);
            let player_id = get_caller_address();

            let mut index: u32 = 0;
            while index < 5 {
                let position: u8 = index.try_into().unwrap();
                let mut letter = LetterTrait::new_guess(player_id, position, word.span()[index].clone());
                store.set_letter(letter);
                index += 1;
            }
        }

        fn verify_guess(
            self: @ComponentState<TContractState>,
            world: IWorldDispatcher,
        ) {
            let store: Store = StoreTrait::new(world);
            let player_id = get_caller_address();

            let mut wordle_progress_array = [ false, false, false, false, false ].span();

            let mut guess_index: u32 = 0;
            while guess_index < 5 {
                let position: u8 = guess_index.try_into().unwrap();
                let guess_letter = store.get_letter(position, true);

                let mut progress_index: u32 = 0;
                while progress_index < 5 {
                    if !wordle_progress_array[progress_index] {
                        let index = progress_index.try_into().unwrap();
                        let wordle_letter = store.get_letter(index, false);
                        let result = LetterTrait::compare_letters(wordle_letter, guess_letter);

                        if result == 2 {
                            let color = LetterTrait::green_color_at_position(index);
                            store.set_color(color);
                            wordle_progress_array[progress_index] = true;
                        } else if result == 1 {
                            let color = LetterTrait::yellow_color_at_position(index);
                            store.set_color(color);
                            wordle_progress_array[index] = true;
                        } else {
                            let color = LetterTrait::gray_color_at_position(index);
                            store.set_color(color);
                        }
                        
                    }
                    progress_index += 1;
                }
                guess_index += 1;
            }

        }
    }
}
