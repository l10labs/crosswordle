use bevy::{input::common_conditions::input_just_pressed, prelude::*};

pub struct GameStatesPlugin;
impl Plugin for GameStatesPlugin {
    fn build(&self, app: &mut App) {
        app.init_state::<GameStates>();
        app.add_systems(
            Update,
            start_game.run_if(input_just_pressed(KeyCode::Space)),
        );
    }
}

#[derive(States, Default, Debug, Clone, PartialEq, Eq, Hash)]
pub enum GameStates {
    #[default]
    StartGame,
    WordleNew,
    WordleSolved,
    GameOver,
}

fn start_game(mut next_state: ResMut<NextState<GameStates>>) {
    next_state.set(GameStates::WordleNew);
}
