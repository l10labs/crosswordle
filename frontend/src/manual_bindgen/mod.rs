use bevy::prelude::Component;

#[derive(Debug, Component, Clone)]
pub struct Letter {
    pub position: u8,
    pub is_user_guess: bool,
    // pub placed_by: ContractAddress,
    pub value: char,
}

#[derive(Debug, Component, Clone)]
pub struct LetterColor {
    pub position: u8,
    pub color: u8,
    // 0: gray, 1: yellow, 2: green
}

// #[derive(Debug, Component, Clone)]
// pub struct Letter {
//     pub position: u8,
//     pub mock_hash: char,
//     // pub hash: Felt,
//     // pub placed_by: ContractAddress,
// }

// #[derive(Debug, Component, Clone)]
// pub struct LetterStatus {
//     pub position: u8,
//     pub status: Status,
// }

// #[derive(Debug, Clone)]
// pub enum Status {
//     Hidden,
//     Solved,
// }
