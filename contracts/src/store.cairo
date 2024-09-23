use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
use crosswordle::models::letter::Letter;

#[derive(Copy, Drop)]
struct Store {
    world: IWorldDispatcher,
}

#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline]
    fn new(world: IWorldDispatcher) -> Store {
        Store { world: world }
    }
}
