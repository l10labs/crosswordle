// Core imports

use core::debug::PrintTrait;
use starknet::ContractAddress;

// Inernal imports

use rpg::models::index::Letter;

mod errors {
    // const PLAYER_NOT_EXIST: felt252 = 'Player: does not exist';
    // const PLAYER_ALREADY_EXIST: felt252 = 'Player: already exist';
    // const PLAYER_INVALID_NAME: felt252 = 'Player: invalid name';
    // const PLAYER_INVALID_CLASS: felt252 = 'Player: invalid role';
    // const PLAYER_INVALID_DIRECTION: felt252 = 'Player: invalid direction';
    // const PLAYER_NOT_ENOUGH_GOLD: felt252 = 'Player: not enough gold';
    const LETTER_NOT_WITHIN_BOUNDS: felt252 = 'Value must be lowercase letter';
    const POSITION_NOT_WITHIN_BOUNDS: felt252 = 'Position must be [0, 4]';
}

#[generate_trait]
impl LetterImpl of LetterTrait {
    #[inline]
    fn new_wordle(placed_by: ContractAddress, position: u8, value: felt252) -> Letter {
        let letter_in_uint: u256 = value.into();
        let lower_bound: u256 = 'a'.into();
        let upper_bound: u256 = 'z'.into();
        let within_bounds: bool = letter_in_uint >= lower_bound && letter_in_uint <= upper_bound;

        assert(within_bounds, errors::LETTER_NOT_WITHIN_BOUNDS);
        assert(position < 5, errors::POSITION_NOT_WITHIN_BOUNDS);

        Letter { placed_by, position, value, is_user_guess: false }
    }

    fn new_guess(placed_by: ContractAddress, position: u8, value: felt252) -> Letter {
        let letter_in_uint: u256 = value.into();
        let lower_bound: u256 = 'a'.into();
        let upper_bound: u256 = 'z'.into();
        let within_bounds: bool = letter_in_uint >= lower_bound && letter_in_uint <= upper_bound;

        assert(within_bounds, errors::LETTER_NOT_WITHIN_BOUNDS);
        assert(position < 5, errors::POSITION_NOT_WITHIN_BOUNDS);

        Letter { placed_by, position, value, is_user_guess: true }
    }
}
