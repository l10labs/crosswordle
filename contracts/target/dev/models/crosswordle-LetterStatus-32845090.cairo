impl LetterStatusIntrospect<> of dojo::model::introspect::Introspect<LetterStatus<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::model::introspect::Introspect::<Status>::size()
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 569306960271936532142884159669739966400652117841771075996122541800876072129,
                    layout: dojo::model::introspect::Introspect::<Status>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'LetterStatus',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'position',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u8>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'status',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<Status>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct LetterStatusEntity {
    __id: felt252, // private field
    pub status: Status,
}

#[generate_trait]
pub impl LetterStatusEntityStoreImpl of LetterStatusEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> LetterStatusEntity {
        LetterStatusModelEntityImpl::get(world, entity_id)
    }

    fn update(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher) {
        dojo::model::ModelEntity::<LetterStatusEntity>::update_entity(self, world);
    }

    fn delete(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher) {
        dojo::model::ModelEntity::<LetterStatusEntity>::delete_entity(self, world);
    }


    fn get_status(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> Status {
        let mut values = dojo::model::ModelEntity::<
            LetterStatusEntity
        >::get_member(
            world,
            entity_id,
            569306960271936532142884159669739966400652117841771075996122541800876072129
        );
        let field_value = core::serde::Serde::<Status>::deserialize(ref values);

        if core::option::OptionTrait::<Status>::is_none(@field_value) {
            panic!("Field `LetterStatus::status`: deserialization failed.");
        }

        core::option::OptionTrait::<Status>::unwrap(field_value)
    }

    fn set_status(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher, value: Status) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                569306960271936532142884159669739966400652117841771075996122541800876072129,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl LetterStatusStoreImpl of LetterStatusStore {
    fn entity_id_from_keys(position: u8) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@position, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> LetterStatus {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<LetterStatus>::deserialize(ref serialized);

        if core::option::OptionTrait::<LetterStatus>::is_none(@entity) {
            panic!(
                "Model `LetterStatus`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<LetterStatus>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, position: u8) -> LetterStatus {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@position, ref serialized);

        dojo::model::Model::<LetterStatus>::get(world, serialized.span())
    }

    fn set(self: @LetterStatus, world: dojo::world::IWorldDispatcher) {
        dojo::model::Model::<LetterStatus>::set_model(self, world);
    }

    fn delete(self: @LetterStatus, world: dojo::world::IWorldDispatcher) {
        dojo::model::Model::<LetterStatus>::delete_model(self, world);
    }


    fn get_status(world: dojo::world::IWorldDispatcher, position: u8) -> Status {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@position, ref serialized);

        let mut values = dojo::model::Model::<
            LetterStatus
        >::get_member(
            world,
            serialized.span(),
            569306960271936532142884159669739966400652117841771075996122541800876072129
        );

        let field_value = core::serde::Serde::<Status>::deserialize(ref values);

        if core::option::OptionTrait::<Status>::is_none(@field_value) {
            panic!("Field `LetterStatus::status`: deserialization failed.");
        }

        core::option::OptionTrait::<Status>::unwrap(field_value)
    }

    fn set_status(self: @LetterStatus, world: dojo::world::IWorldDispatcher, value: Status) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                569306960271936532142884159669739966400652117841771075996122541800876072129,
                serialized.span()
            );
    }
}

pub impl LetterStatusModelEntityImpl of dojo::model::ModelEntity<LetterStatusEntity> {
    fn id(self: @LetterStatusEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @LetterStatusEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.status, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> LetterStatusEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<LetterStatusEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<LetterStatusEntity>::is_none(@entity_values) {
            panic!("ModelEntity `LetterStatusEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<LetterStatusEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> LetterStatusEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<LetterStatus>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update_entity(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<LetterStatus>::layout()
        );
    }

    fn delete_entity(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<LetterStatus>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<LetterStatus>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<LetterStatus>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @LetterStatusEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<LetterStatus>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<LetterStatus>::selector(),
                    dojo::model::ModelIndex::MemberId((self.id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }
}

#[cfg(target: "test")]
pub impl LetterStatusModelEntityTestImpl of dojo::model::ModelEntityTest<LetterStatusEntity> {
    fn update_test(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<LetterStatus>::layout()
        );
    }

    fn delete_test(self: @LetterStatusEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<LetterStatus>::layout()
        );
    }
}

pub impl LetterStatusModelImpl of dojo::model::Model<LetterStatus> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> LetterStatus {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        LetterStatusStore::from_values(ref _keys, ref values)
    }

    fn set_model(self: @LetterStatus, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete_model(self: @LetterStatus, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(Self::keys(self)), Self::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, keys: Span<felt252>, member_id: felt252
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(Self::layout(), member_id) {
            Option::Some(field_layout) => {
                let entity_id = dojo::utils::entity_id_from_keys(keys);
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    Self::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @LetterStatus,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>
    ) {
        match dojo::utils::find_model_field_layout(Self::layout(), member_id) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    Self::selector(),
                    dojo::model::ModelIndex::MemberId((self.entity_id(), member_id)),
                    values,
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    #[inline(always)]
    fn name() -> ByteArray {
        "LetterStatus"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "crosswordle"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "crosswordle-LetterStatus"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        1428088892762227631395997724090986670350790061249863827055003064140477852848
    }

    #[inline(always)]
    fn instance_selector(self: @LetterStatus) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        3161886877854241414469438067069538000898463471187017536947434802785695041864
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        412597028710285953985042866789150238702572377910784654248646416465155076019
    }

    #[inline(always)]
    fn entity_id(self: @LetterStatus) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @LetterStatus) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.position, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @LetterStatus) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.status, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<LetterStatus>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @LetterStatus) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl LetterStatusModelTestImpl of dojo::model::ModelTest<LetterStatus> {
    fn set_test(self: @LetterStatus, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<LetterStatus>::keys(self)),
            dojo::model::Model::<LetterStatus>::values(self),
            dojo::model::Model::<LetterStatus>::layout()
        );
    }

    fn delete_test(self: @LetterStatus, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<LetterStatus>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<LetterStatus>::keys(self)),
            dojo::model::Model::<LetterStatus>::layout()
        );
    }
}

#[starknet::interface]
pub trait Iletter_status<T> {
    fn ensure_abi(self: @T, model: LetterStatus);
}

#[starknet::contract]
pub mod letter_status {
    use super::LetterStatus;
    use super::Iletter_status;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<LetterStatus>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<LetterStatus>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<LetterStatus>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<LetterStatus>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<LetterStatus>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<LetterStatus>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<LetterStatus>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<LetterStatus>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<LetterStatus>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<LetterStatus>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<LetterStatus>::ty()
        }
    }

    #[abi(embed_v0)]
    impl letter_statusImpl of Iletter_status<ContractState> {
        fn ensure_abi(self: @ContractState, model: LetterStatus) {}
    }
}
