#[starknet::contract]
pub mod create_actions {
    use dojo::world;
    use dojo::world::IWorldDispatcher;
    use dojo::world::IWorldDispatcherTrait;
    use dojo::world::IWorldProvider;
    use dojo::contract::IContract;
    use starknet::storage::{
        StorageMapReadAccess, StorageMapWriteAccess, StoragePointerReadAccess,
        StoragePointerWriteAccess
    };

    component!(
        path: dojo::contract::upgradeable::upgradeable,
        storage: upgradeable,
        event: UpgradeableEvent
    );

    #[abi(embed_v0)]
    pub impl ContractImpl of IContract<ContractState> {
        fn contract_name(self: @ContractState) -> ByteArray {
            "create_actions"
        }

        fn namespace(self: @ContractState) -> ByteArray {
            "crosswordle"
        }

        fn tag(self: @ContractState) -> ByteArray {
            "crosswordle-create_actions"
        }

        fn name_hash(self: @ContractState) -> felt252 {
            3200939374238058190916447114639770040544906320151553814952432759740095857864
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            412597028710285953985042866789150238702572377910784654248646416465155076019
        }

        fn selector(self: @ContractState) -> felt252 {
            478612612608531351559818201424019449739789617373193813245906261560519118238
        }
    }

    #[abi(embed_v0)]
    impl WorldProviderImpl of IWorldProvider<ContractState> {
        fn world(self: @ContractState) -> IWorldDispatcher {
            self.world_dispatcher.read()
        }
    }

    #[abi(embed_v0)]
    impl UpgradableImpl =
        dojo::contract::upgradeable::upgradeable::UpgradableImpl<ContractState>;

    use super::ICreate;
    use super::NUM_LETTERS;
    use starknet::{ContractAddress, get_caller_address};
    use crosswordle::models::board::{Letter, Status, LetterStatus};


    #[abi(embed_v0)]
    impl CreateImpl of ICreate<ContractState> {
        fn create_letter(ref self: ContractState, character: felt252, position: u8) {
            let world = self.world_dispatcher.read();
            let placed_by = get_caller_address();
            let single_letter = Letter { position, hash: character, placed_by, };

            set!(world, (single_letter));
        }
        fn create_word(ref self: ContractState, word: [felt252; NUM_LETTERS]) {
            let world = self.world_dispatcher.read();
            let placed_by = get_caller_address();
            let word_span = word.span();

            let mut index = 0;
            while index < NUM_LETTERS {
                let position = index.try_into().unwrap();
                let single_letter = Letter { position, hash: word_span[index].clone(), placed_by };
                set!(world, (single_letter));

                index += 1;
            }
        }
        fn create_hidden_word(ref self: ContractState, word: [felt252; NUM_LETTERS]) {
            let world = self.world_dispatcher.read();
            let placed_by = get_caller_address();
            let word_span = word.span();

            let mut index = 0;
            while index < NUM_LETTERS {
                let position = index.try_into().unwrap();
                let single_letter = Letter { position, hash: word_span[index].clone(), placed_by };
                let letter_status = LetterStatus { position, status: Status::Hidden };
                set!(world, (single_letter, letter_status));

                index += 1;
            }
        }
        fn solve_letter(ref self: ContractState, character: felt252, letter_location: u8) {
            let world = self.world_dispatcher.read(); // let solved_by = get_caller_address();

            let (letter, status) = get!(world, (letter_location), (Letter, LetterStatus));

            // verify the letter is currently hidden
            let curr_status: felt252 = status.status.into();
            let hidden_status = Status::Hidden.into();
            assert!(curr_status == hidden_status, "Letter is already solved");

            // check if user guessed the correct letter
            assert!(character == letter.hash, "Letter is guessed incorrectly");
            let new_status = LetterStatus { position: letter_location, status: Status::Solved };

            // change status to `Solved` after sucsessfull guess
            set!(world, (letter, new_status));
        }
    }
    #[starknet::interface]
    pub trait IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState);
    }

    #[abi(embed_v0)]
    pub impl IDojoInitImpl of IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState) {
            if starknet::get_caller_address() != self.world().contract_address {
                core::panics::panic_with_byte_array(
                    @format!(
                        "Only the world can init contract `{}`, but caller is `{:?}`",
                        self.tag(),
                        starknet::get_caller_address(),
                    )
                );
            }
        }
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: dojo::contract::upgradeable::upgradeable::Event,
    }

    #[storage]
    struct Storage {
        world_dispatcher: IWorldDispatcher,
        #[substorage(v0)]
        upgradeable: dojo::contract::upgradeable::upgradeable::Storage,
    }
}

