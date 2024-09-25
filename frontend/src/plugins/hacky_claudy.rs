use bevy::input::keyboard::{Key, KeyboardInput};
use bevy::input::ButtonState;
use bevy::prelude::*;
use rand::seq::SliceRandom;
use std::collections::HashSet;

const WORD_LENGTH: usize = 5;
const MAX_GUESSES: usize = 6;

pub struct WordlePlugin;

impl Plugin for WordlePlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<WordleGame>()
            .add_systems(Startup, setup)
            .add_systems(Update, (handle_input, update_display));
    }
}

#[derive(Resource)]
struct WordleGame {
    target_word: String,
    guesses: Vec<String>,
    current_guess: String,
    game_over: bool,
    word_list: Vec<String>,
}

impl Default for WordleGame {
    fn default() -> Self {
        let word_list = vec![
            "apple".to_string(),
            "beach".to_string(),
            "chair".to_string(),
            "dance".to_string(),
            "eagle".to_string(), // Add more words here
        ];
        let target_word = word_list
            .choose(&mut rand::thread_rng())
            .unwrap()
            .to_string();

        Self {
            target_word,
            guesses: Vec::new(),
            current_guess: String::new(),
            game_over: false,
            word_list,
        }
    }
}

fn setup(mut commands: Commands, asset_server: Res<AssetServer>) {
    commands.spawn(
        TextBundle::from_section(
            "Wordle Game",
            TextStyle {
                font: asset_server.load("fonts/FiraSans-Bold.ttf"),
                font_size: 40.0,
                color: Color::WHITE,
            },
        )
        .with_style(Style {
            position_type: PositionType::Absolute,
            top: Val::Px(10.0),
            left: Val::Px(10.0),
            ..default()
        }),
    );

    commands
        .spawn(
            TextBundle::from_section(
                "",
                TextStyle {
                    font: asset_server.load("fonts/FiraSans-Bold.ttf"),
                    font_size: 24.0,
                    color: Color::WHITE,
                },
            )
            .with_style(Style {
                position_type: PositionType::Absolute,
                top: Val::Px(60.0),
                left: Val::Px(10.0),
                ..default()
            }),
        )
        .insert(GuessesDisplay);
}

#[derive(Component)]
struct GuessesDisplay;

fn handle_input(mut game: ResMut<WordleGame>, mut evr_kbd: EventReader<KeyboardInput>) {
    if game.game_over {
        return;
    }

    for ev in evr_kbd.read() {
        if ev.state == ButtonState::Released {
            continue;
        }
        match &ev.logical_key {
            Key::Enter => {
                if game.current_guess.len() == WORD_LENGTH
                    && game.word_list.contains(&game.current_guess)
                {
                    let current_guess = game.current_guess.clone();
                    game.guesses.push(current_guess);

                    if game.current_guess == game.target_word {
                        game.game_over = true;
                    } else if game.guesses.len() >= MAX_GUESSES {
                        game.game_over = true;
                    }

                    game.current_guess.clear();
                }
            }
            Key::Backspace => {
                game.current_guess.pop();
            }
            Key::Character(c) => {
                let letter_a_upper: u32 = 'A'.into();
                let letter_z_upper: u32 = 'Z'.into();
                let letter_a_lower: u32 = 'a'.into();
                let letter_z_lower: u32 = 'z'.into();
                let char_code: u32 = c.clone().chars().next().unwrap().into();

                if (char_code >= letter_a_lower && char_code <= letter_z_lower)
                    || (char_code >= letter_a_upper && char_code <= letter_z_upper)
                {
                    println!("Typed: {}", c);
                    if game.current_guess.len() < WORD_LENGTH {
                        game.current_guess
                            .push(c.chars().next().unwrap().to_ascii_lowercase());
                    } else {
                        println!("Already typed 5 letters!");
                    }
                } else {
                    println!("Invalid character: {}", c);
                }
            }
            _ => {}
        }
    }
}

fn update_display(game: Res<WordleGame>, mut query: Query<&mut Text, With<GuessesDisplay>>) {
    let mut text = query.single_mut();
    let mut display = String::new();

    for guess in &game.guesses {
        display.push_str(&format_guess(guess, &game.target_word));
        display.push('\n');
    }

    if !game.current_guess.is_empty() {
        display.push_str(&game.current_guess);
        display.push_str(&" ".repeat(WORD_LENGTH - game.current_guess.len()));
        display.push('\n');
    }

    if game.game_over {
        let last_guess = game.guesses.last();
        let game_string = if last_guess == Some(&game.target_word) {
            "\nCongratulations! You guessed the word!"
        } else {
            &format!("\nGame Over! The word was: {}", game.target_word)
        };
        display.push_str(game_string);
    }

    text.sections[0].value = display;
}

fn format_guess(guess: &str, target: &str) -> String {
    let mut result = String::new();
    let mut used_indices = HashSet::new();

    // First pass: mark correct letters
    for (i, (g, t)) in guess.chars().zip(target.chars()).enumerate() {
        if g == t {
            result.push('🟩');
            used_indices.insert(i);
        } else {
            result.push('⬜');
        }
    }

    // Second pass: mark misplaced letters
    for (i, g) in guess.chars().enumerate() {
        if !used_indices.contains(&i) {
            if target
                .chars()
                .enumerate()
                .any(|(j, t)| g == t && !used_indices.contains(&j))
            {
                result.replace_range(i..i + 1, "🟨");
                used_indices.insert(i);
            }
        }
    }

    result
}
