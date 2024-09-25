use bevy::{ecs::query, input::common_conditions::input_just_pressed, prelude::*};

use crate::manual_bindgen::Letter;

use super::set_color::{GuessResult, LetterStatus};

pub struct GameStatesPlugin;
impl Plugin for GameStatesPlugin {
    fn build(&self, app: &mut App) {
        app.init_state::<GameStates>();
        app.add_systems(
            Update,
            start_game.run_if(
                in_state(GameStates::StartGame).and_then(input_just_pressed(KeyCode::Space)),
            ),
        );
        app.add_systems(
            Update,
            complete_level.run_if(in_state(GameStates::WordleNew)),
        );
        app.add_systems(
            Update,
            next_new_word.run_if(
                in_state(GameStates::WordleSolved).and_then(
                    input_just_pressed(KeyCode::ShiftLeft)
                        .or_else(input_just_pressed(KeyCode::ShiftRight)),
                ),
            ),
        );
        app.add_systems(
            Update,
            restart_game.run_if(input_just_pressed(KeyCode::Escape)),
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

fn next_new_word(mut next_state: ResMut<NextState<GameStates>>, result: Res<GuessResult>) {
    info!("TIME TO START THE NEXT NEW LEVEL!");

    next_state.set(GameStates::WordleNew);
}

fn restart_game(
    mut next_state: ResMut<NextState<GameStates>>,
    query: Query<(Entity, &Letter)>,
    mut commands: Commands,
) {
    info!("Restarting the game!");
    for (id, letter) in query.iter() {
        info!("Despawning entities: {:?}", letter);
        commands.entity(id).despawn();
    }
    next_state.set(GameStates::StartGame);
}
