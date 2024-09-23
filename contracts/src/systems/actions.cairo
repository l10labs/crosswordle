
#[dojo::interface]
trait ICreate {
    fn create_letter(ref world: IWorldDispatcher, character: felt252, position: u8);
}

#[dojo::contract]
mod create_actions {
    use super::ICreate;
    use crosswordle::models::letter::LetterTrait;
    use starknet::{ContractAddress, get_caller_address};

    #[abi(embed_v0)]
    impl CreateImpl of ICreate<ContractState> {
        fn create_letter(ref world: IWorldDispatcher, character: felt252, position: u8) {
            let letter = LetterTrait::new(position, character, get_caller_address());
        }

    }
}