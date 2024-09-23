impl LetterIntrospect<> of dojo::model::introspect::Introspect<Letter<>> {
    #[inline(always)]
    fn size() -> Option<usize> {
        Option::Some(2)
    }

    fn layout() -> dojo::model::Layout {
        dojo::model::Layout::Struct(
            array![
                dojo::model::FieldLayout {
                    selector: 1441742700868051836623478562545357970691020237306020720449586918617316042917,
                    layout: dojo::model::introspect::Introspect::<ContractAddress>::layout()
                },
                dojo::model::FieldLayout {
                    selector: 1312974614278331581093775211924685600756172115645956279915000968107055095839,
                    layout: dojo::model::introspect::Introspect::<felt252>::layout()
                }
            ]
                .span()
        )
    }

    #[inline(always)]
    fn ty() -> dojo::model::introspect::Ty {
        dojo::model::introspect::Ty::Struct(
            dojo::model::introspect::Struct {
                name: 'Letter',
                attrs: array![].span(),
                children: array![
                    dojo::model::introspect::Member {
                        name: 'id',
                        attrs: array!['key'].span(),
                        ty: dojo::model::introspect::Introspect::<u32>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'player_address',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<ContractAddress>::ty()
                    },
                    dojo::model::introspect::Member {
                        name: 'letter',
                        attrs: array![].span(),
                        ty: dojo::model::introspect::Introspect::<felt252>::ty()
                    }
                ]
                    .span()
            }
        )
    }
}

#[derive(Drop, Serde)]
pub struct LetterEntity {
    __id: felt252, // private field
    pub player_address: ContractAddress,
    pub letter: felt252,
}

#[generate_trait]
pub impl LetterEntityStoreImpl of LetterEntityStore {
    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> LetterEntity {
        LetterModelEntityImpl::get(world, entity_id)
    }

    fn update(self: @LetterEntity, world: dojo::world::IWorldDispatcher) {
        dojo::model::ModelEntity::<LetterEntity>::update_entity(self, world);
    }

    fn delete(self: @LetterEntity, world: dojo::world::IWorldDispatcher) {
        dojo::model::ModelEntity::<LetterEntity>::delete_entity(self, world);
    }


    fn get_player_address(
        world: dojo::world::IWorldDispatcher, entity_id: felt252
    ) -> ContractAddress {
        let mut values = dojo::model::ModelEntity::<
            LetterEntity
        >::get_member(
            world,
            entity_id,
            1441742700868051836623478562545357970691020237306020720449586918617316042917
        );
        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Letter::player_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_player_address(
        self: @LetterEntity, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1441742700868051836623478562545357970691020237306020720449586918617316042917,
                serialized.span()
            );
    }

    fn get_letter(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> felt252 {
        let mut values = dojo::model::ModelEntity::<
            LetterEntity
        >::get_member(
            world,
            entity_id,
            1312974614278331581093775211924685600756172115645956279915000968107055095839
        );
        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Letter::letter`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_letter(self: @LetterEntity, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1312974614278331581093775211924685600756172115645956279915000968107055095839,
                serialized.span()
            );
    }
}

#[generate_trait]
pub impl LetterStoreImpl of LetterStore {
    fn entity_id_from_keys(id: u32) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@id, ref serialized);

        core::poseidon::poseidon_hash_span(serialized.span())
    }

    fn from_values(ref keys: Span<felt252>, ref values: Span<felt252>) -> Letter {
        let mut serialized = core::array::ArrayTrait::new();
        serialized.append_span(keys);
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity = core::serde::Serde::<Letter>::deserialize(ref serialized);

        if core::option::OptionTrait::<Letter>::is_none(@entity) {
            panic!(
                "Model `Letter`: deserialization failed. Ensure the length of the keys tuple is matching the number of #[key] fields in the model struct."
            );
        }

        core::option::OptionTrait::<Letter>::unwrap(entity)
    }

    fn get(world: dojo::world::IWorldDispatcher, id: u32) -> Letter {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@id, ref serialized);

        dojo::model::Model::<Letter>::get(world, serialized.span())
    }

    fn set(self: @Letter, world: dojo::world::IWorldDispatcher) {
        dojo::model::Model::<Letter>::set_model(self, world);
    }

    fn delete(self: @Letter, world: dojo::world::IWorldDispatcher) {
        dojo::model::Model::<Letter>::delete_model(self, world);
    }


    fn get_player_address(world: dojo::world::IWorldDispatcher, id: u32) -> ContractAddress {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            Letter
        >::get_member(
            world,
            serialized.span(),
            1441742700868051836623478562545357970691020237306020720449586918617316042917
        );

        let field_value = core::serde::Serde::<ContractAddress>::deserialize(ref values);

        if core::option::OptionTrait::<ContractAddress>::is_none(@field_value) {
            panic!("Field `Letter::player_address`: deserialization failed.");
        }

        core::option::OptionTrait::<ContractAddress>::unwrap(field_value)
    }

    fn set_player_address(
        self: @Letter, world: dojo::world::IWorldDispatcher, value: ContractAddress
    ) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1441742700868051836623478562545357970691020237306020720449586918617316042917,
                serialized.span()
            );
    }

    fn get_letter(world: dojo::world::IWorldDispatcher, id: u32) -> felt252 {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@id, ref serialized);

        let mut values = dojo::model::Model::<
            Letter
        >::get_member(
            world,
            serialized.span(),
            1312974614278331581093775211924685600756172115645956279915000968107055095839
        );

        let field_value = core::serde::Serde::<felt252>::deserialize(ref values);

        if core::option::OptionTrait::<felt252>::is_none(@field_value) {
            panic!("Field `Letter::letter`: deserialization failed.");
        }

        core::option::OptionTrait::<felt252>::unwrap(field_value)
    }

    fn set_letter(self: @Letter, world: dojo::world::IWorldDispatcher, value: felt252) {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(@value, ref serialized);

        self
            .set_member(
                world,
                1312974614278331581093775211924685600756172115645956279915000968107055095839,
                serialized.span()
            );
    }
}

pub impl LetterModelEntityImpl of dojo::model::ModelEntity<LetterEntity> {
    fn id(self: @LetterEntity) -> felt252 {
        *self.__id
    }

    fn values(self: @LetterEntity) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player_address, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.letter);

        core::array::ArrayTrait::span(@serialized)
    }

    fn from_values(entity_id: felt252, ref values: Span<felt252>) -> LetterEntity {
        let mut serialized = array![entity_id];
        serialized.append_span(values);
        let mut serialized = core::array::ArrayTrait::span(@serialized);

        let entity_values = core::serde::Serde::<LetterEntity>::deserialize(ref serialized);
        if core::option::OptionTrait::<LetterEntity>::is_none(@entity_values) {
            panic!("ModelEntity `LetterEntity`: deserialization failed.");
        }
        core::option::OptionTrait::<LetterEntity>::unwrap(entity_values)
    }

    fn get(world: dojo::world::IWorldDispatcher, entity_id: felt252) -> LetterEntity {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Id(entity_id),
            dojo::model::Model::<Letter>::layout()
        );
        Self::from_values(entity_id, ref values)
    }

    fn update_entity(self: @LetterEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Letter>::layout()
        );
    }

    fn delete_entity(self: @LetterEntity, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::delete_entity(
            world,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Letter>::layout()
        );
    }

    fn get_member(
        world: dojo::world::IWorldDispatcher, entity_id: felt252, member_id: felt252,
    ) -> Span<felt252> {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Letter>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::entity(
                    world,
                    dojo::model::Model::<Letter>::selector(),
                    dojo::model::ModelIndex::MemberId((entity_id, member_id)),
                    field_layout
                )
            },
            Option::None => core::panic_with_felt252('bad member id')
        }
    }

    fn set_member(
        self: @LetterEntity,
        world: dojo::world::IWorldDispatcher,
        member_id: felt252,
        values: Span<felt252>,
    ) {
        match dojo::utils::find_model_field_layout(
            dojo::model::Model::<Letter>::layout(), member_id
        ) {
            Option::Some(field_layout) => {
                dojo::world::IWorldDispatcherTrait::set_entity(
                    world,
                    dojo::model::Model::<Letter>::selector(),
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
pub impl LetterModelEntityTestImpl of dojo::model::ModelEntityTest<LetterEntity> {
    fn update_test(self: @LetterEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            self.values(),
            dojo::model::Model::<Letter>::layout()
        );
    }

    fn delete_test(self: @LetterEntity, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Id(self.id()),
            dojo::model::Model::<Letter>::layout()
        );
    }
}

pub impl LetterModelImpl of dojo::model::Model<Letter> {
    fn get(world: dojo::world::IWorldDispatcher, keys: Span<felt252>) -> Letter {
        let mut values = dojo::world::IWorldDispatcherTrait::entity(
            world, Self::selector(), dojo::model::ModelIndex::Keys(keys), Self::layout()
        );
        let mut _keys = keys;

        LetterStore::from_values(ref _keys, ref values)
    }

    fn set_model(self: @Letter, world: dojo::world::IWorldDispatcher) {
        dojo::world::IWorldDispatcherTrait::set_entity(
            world,
            Self::selector(),
            dojo::model::ModelIndex::Keys(Self::keys(self)),
            Self::values(self),
            Self::layout()
        );
    }

    fn delete_model(self: @Letter, world: dojo::world::IWorldDispatcher) {
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
        self: @Letter,
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
        "Letter"
    }

    #[inline(always)]
    fn namespace() -> ByteArray {
        "crosswordle"
    }

    #[inline(always)]
    fn tag() -> ByteArray {
        "crosswordle-Letter"
    }

    #[inline(always)]
    fn version() -> u8 {
        1
    }

    #[inline(always)]
    fn selector() -> felt252 {
        936051578321689713522282161680386267912954488616560366269518258642773126824
    }

    #[inline(always)]
    fn instance_selector(self: @Letter) -> felt252 {
        Self::selector()
    }

    #[inline(always)]
    fn name_hash() -> felt252 {
        1996885239693869580861954311598040897950504026003024609151985927889267489486
    }

    #[inline(always)]
    fn namespace_hash() -> felt252 {
        412597028710285953985042866789150238702572377910784654248646416465155076019
    }

    #[inline(always)]
    fn entity_id(self: @Letter) -> felt252 {
        core::poseidon::poseidon_hash_span(self.keys())
    }

    #[inline(always)]
    fn keys(self: @Letter) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn values(self: @Letter) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.player_address, ref serialized);
        core::array::ArrayTrait::append(ref serialized, *self.letter);

        core::array::ArrayTrait::span(@serialized)
    }

    #[inline(always)]
    fn layout() -> dojo::model::Layout {
        dojo::model::introspect::Introspect::<Letter>::layout()
    }

    #[inline(always)]
    fn instance_layout(self: @Letter) -> dojo::model::Layout {
        Self::layout()
    }

    #[inline(always)]
    fn packed_size() -> Option<usize> {
        dojo::model::layout::compute_packed_size(Self::layout())
    }
}

#[cfg(target: "test")]
pub impl LetterModelTestImpl of dojo::model::ModelTest<Letter> {
    fn set_test(self: @Letter, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::set_entity_test(
            world_test,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<Letter>::keys(self)),
            dojo::model::Model::<Letter>::values(self),
            dojo::model::Model::<Letter>::layout()
        );
    }

    fn delete_test(self: @Letter, world: dojo::world::IWorldDispatcher) {
        let world_test = dojo::world::IWorldTestDispatcher {
            contract_address: world.contract_address
        };

        dojo::world::IWorldTestDispatcherTrait::delete_entity_test(
            world_test,
            dojo::model::Model::<Letter>::selector(),
            dojo::model::ModelIndex::Keys(dojo::model::Model::<Letter>::keys(self)),
            dojo::model::Model::<Letter>::layout()
        );
    }
}

#[starknet::interface]
pub trait Iletter<T> {
    fn ensure_abi(self: @T, model: Letter);
}

#[starknet::contract]
pub mod letter {
    use super::Letter;
    use super::Iletter;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl DojoModelImpl of dojo::model::IModel<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Letter>::name()
        }

        fn namespace(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Letter>::namespace()
        }

        fn tag(self: @ContractState) -> ByteArray {
            dojo::model::Model::<Letter>::tag()
        }

        fn version(self: @ContractState) -> u8 {
            dojo::model::Model::<Letter>::version()
        }

        fn selector(self: @ContractState) -> felt252 {
            dojo::model::Model::<Letter>::selector()
        }

        fn name_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Letter>::name_hash()
        }

        fn namespace_hash(self: @ContractState) -> felt252 {
            dojo::model::Model::<Letter>::namespace_hash()
        }

        fn unpacked_size(self: @ContractState) -> Option<usize> {
            dojo::model::introspect::Introspect::<Letter>::size()
        }

        fn packed_size(self: @ContractState) -> Option<usize> {
            dojo::model::Model::<Letter>::packed_size()
        }

        fn layout(self: @ContractState) -> dojo::model::Layout {
            dojo::model::Model::<Letter>::layout()
        }

        fn schema(self: @ContractState) -> dojo::model::introspect::Ty {
            dojo::model::introspect::Introspect::<Letter>::ty()
        }
    }

    #[abi(embed_v0)]
    impl letterImpl of Iletter<ContractState> {
        fn ensure_abi(self: @ContractState, model: Letter) {}
    }
}
