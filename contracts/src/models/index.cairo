use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Player {
    #[key]
    pub id: felt252,
    pub mode: u8,
    pub role: u8,
    pub damage: u8,
    pub health: u8,
    pub gold: u16,
    pub score: u16,
    pub seed: felt252,
    pub name: felt252,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Dungeon {
    #[key]
    pub id: felt252,
    pub monster: u8,
    pub role: u8,
    pub damage: u8,
    pub health: u8,
    pub reward: u16,
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Letter {
    #[key]
    pub position: u8,
    #[key]
    pub is_user_guess: bool,
    pub placed_by: ContractAddress,
    pub value: felt252,
}
