use bevy::{input::common_conditions::input_just_pressed, prelude::*};

use super::set_color::{GuessResult, LetterStatus};

pub struct GameStatesPlugin;
impl Plugin for GameStatesPlugin {
    fn build(&self, app: &mut App) {
        app.init_state::<GameStates>();
        app.add_systems(
            Update,
            start_game.run_if(input_just_pressed(KeyCode::Space)),
        );
        app.add_systems(
            Update,
            complete_level.run_if(in_state(GameStates::WordleNew)),
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

fn complete_level(mut next_state: ResMut<NextState<GameStates>>, result: Res<GuessResult>) {
    let mut should_advance = true;
    for status in result.0.iter() {
        if *status != LetterStatus::Green {
            should_advance = false;
            break;
        }
    }
    if should_advance {
        next_state.set(GameStates::WordleSolved);
    }
}
