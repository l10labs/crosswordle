use starknet::{ContractAddress, get_caller_address};

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Letter {
    #[key]
    pub position: u8,
    #[key]
    pub placed_by: ContractAddress,
    pub value: felt252,
}

mod errors {
    const INVALID_LETTER: felt252 = 'Invalid letter value';
}

#[generate_trait]
impl LetterImpl of LetterTrait {
    #[inline]
    fn new(position: u8, value: felt252, placed_by: ContractAddress) -> Letter {
        let min_value: u256 = 'a';
        let max_value: u256 = 'z';
        let value: u256 = value.into();

        assert(value >= min_value && value <= max_value, errors::INVALID_LETTER);

        Letter {
            position,
            value: value.try_into().unwrap(),
            placed_by,
        }
    }
}

#[cfg(test)]
mod tests {

    use super::{LetterTrait};

    #[test]
    fn test_letter_new() {
        let letter = LetterTrait::new(0, 'z');
        assert_eq!(letter.position, 0);
        assert_eq!(letter.value, 'z');
    }
}