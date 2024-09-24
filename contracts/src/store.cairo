//! Store struct and component management methods.

// Dojo imports

use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};

// Models imports

use rpg::models::player::Player;
use rpg::models::dungeon::Dungeon;
use rpg::models::index::Letter;
use rpg::models::index::Color;


// Structs

#[derive(Copy, Drop)]
struct Store {
    world: IWorldDispatcher,
}

// Implementations

#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline]
    fn new(world: IWorldDispatcher) -> Store {
        Store { world: world }
    }

    #[inline]
    fn get_state(self: Store, player_id: felt252) -> (Player, Dungeon) {
        get!(self.world, player_id, (Player, Dungeon))
    }

    #[inline]
    fn get_player(self: Store, player_id: felt252) -> Player {
        get!(self.world, player_id, (Player))
    }

    #[inline]
    fn get_dungeon(self: Store, player_id: felt252) -> Dungeon {
        get!(self.world, player_id, (Dungeon))
    }

    #[inline]
    fn set_state(self: Store, player: Player, dungeon: Dungeon) {
        set!(self.world, (player, dungeon))
    }

    #[inline]
    fn set_player(self: Store, player: Player) {
        set!(self.world, (player))
    }

    #[inline]
    fn set_dungeon(self: Store, dungeon: Dungeon) {
        set!(self.world, (dungeon))
    }

    #[inline]
    fn set_letter(self: Store, letter: Letter) {
        set!(self.world, (letter))
    }

    #[inline]
    fn get_letter(self: Store, position: u8, is_user_guess: bool) -> Letter {
        get!(self.world, (position, is_user_guess), (Letter))
    }

    #[inline]
    fn set_color(self: Store, color: Color) {
        set!(self.world, (color))
    }

    #[inline]
    fn get_color(self: Store, position: u8) -> Color {
        get!(self.world, (position), (Color))
    }
}
