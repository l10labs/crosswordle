use starknet::ContractAddress;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Letter {
    #[key]
    pub id: u32,
    pub player_address: ContractAddress,
    pub letter: felt252,
}
