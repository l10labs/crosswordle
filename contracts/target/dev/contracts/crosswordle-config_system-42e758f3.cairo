#[starknet::contract]
pub mod config_system {
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
            "config_system"
        }

        fn namespace(self: @ContractState) -> ByteArray {
            "crosswordle"
        }

        fn tag(self: @ContractState) -> ByteArray {
            "crosswordle-config_system"
        }

        fn name_hash(self: @ContractState) -> felt252 {
            1718428157116343790953255626103133443901889712624082698096731682116239698832
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            412597028710285953985042866789150238702572377910784654248646416465155076019
        }

        fn selector(self: @ContractState) -> felt252 {
            1891337724329945351328462565676689763072516786108862783262597510148462747489
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

    use crosswordle::store::{Store, StoreTrait};
    use crosswordle::models::letter::Letter;
    #[starknet::interface]
    pub trait IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState);
    }

    #[abi(embed_v0)]
    pub impl IDojoInitImpl of IDojoInit<ContractState> {
        fn dojo_init(self: @ContractState) {
            let world = self.world_dispatcher.read();
            if starknet::get_caller_address() != self.world().contract_address {
                core::panics::panic_with_byte_array(
                    @format!(
                        "Only the world can init contract `{}`, but caller is `{:?}`",
                        self.tag(),
                        starknet::get_caller_address()
                    )
                );
            }
            let mut store: Store = StoreTrait::new(world);
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

