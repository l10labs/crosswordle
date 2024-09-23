use dojo::world::IWorldDispatcher;
use dojo::world::IWorldDispatcherTrait;

#[dojo::interface]
trait ICreate {
    fn create_letter(ref world: IWorldDispatcher, character: felt252, position: u8);
    // fn create_word(ref world: IWorldDispatcher, word: [felt252; 5]);

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
            set!(world, (letter));
        }

        // fn create_word(ref world: IWorldDispatcher, word: [felt252; 5]) {
        //     let mut index = 0;
        //     let caller = get_caller_address();
        //     let word_span = word.span();

        //     while index < word_span.len() {
        //         let single_letter = LetterTrait::new(index.try_into().unwrap(), word_span[index].clone(), caller);
        //         set!(world, (single_letter));
        //         index += 1;
        //     }
        // }

    }
}