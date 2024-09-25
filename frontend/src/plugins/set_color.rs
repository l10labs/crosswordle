use bevy::{input::common_conditions::input_just_pressed, prelude::*, transform::commands};

use crate::manual_bindgen::Letter;

use super::{
    constants::{COLOR_HEIGHT, MULTIPLIER, SCALE},
    game_states::GameStates,
    visualize::KeysTextureAtlas,
};

pub struct SetColorPlugin;
impl Plugin for SetColorPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Startup, init_guess);
        app.add_systems(
            Update,
            (check_guess, remove_old_colors, spawn_color)
                .chain()
                .run_if(input_just_pressed(KeyCode::Enter)),
        );
        app.add_systems(
            OnExit(GameStates::WordleSolved),
            (reset_colors, remove_old_colors),
        );
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum LetterStatus {
    Grey,   // Letter not in the word
    Yellow, // Letter in the word but wrong position
    Green,  // Letter in the correct position
}

#[derive(Resource)]
pub struct GuessResult(pub Vec<LetterStatus>);

fn init_guess(mut commands: Commands) {
    let init_guess = vec![
        LetterStatus::Grey,
        LetterStatus::Grey,
        LetterStatus::Grey,
        LetterStatus::Grey,
        LetterStatus::Grey,
    ];
    commands.insert_resource(GuessResult(init_guess));
}

fn check_guess(query: Query<&Letter>, mut commands: Commands, mut result: ResMut<GuessResult>) {
    let mut answer: Vec<char> = vec![];
    let mut guess: Vec<char> = vec![];

    if query.iter().count() == 10 {
        // Assuming 5 letters for answer and 5 for guess
        for letter in query.iter() {
            if letter.is_user_guess {
                guess.push(letter.value);
            } else {
                answer.push(letter.value);
            }
        }

        let new_result = compare_guess(&answer, &guess);

        info!("Guess Result: {:?}", new_result);
        // commands.insert_resource(GuessResult(result));
        result.0 = new_result;
    }
}

fn compare_guess(answer: &[char], guess: &[char]) -> Vec<LetterStatus> {
    let mut result = vec![LetterStatus::Grey; guess.len()];
    let mut used_answer_indices = vec![false; answer.len()];

    // First pass: Check for correct positions (Green)
    for (i, &g) in guess.iter().enumerate() {
        if g == answer[i] {
            result[i] = LetterStatus::Green;
            used_answer_indices[i] = true;
        }
    }

    // Second pass: Check for correct letters in wrong positions (Yellow)
    for (i, &g) in guess.iter().enumerate() {
        if result[i] == LetterStatus::Grey {
            for (j, &a) in answer.iter().enumerate() {
                if !used_answer_indices[j] && g == a {
                    result[i] = LetterStatus::Yellow;
                    used_answer_indices[j] = true;
                    break;
                }
            }
        }
    }

    result
}

#[derive(Debug, Component)]
struct ColorImage;

fn spawn_color(result: Res<GuessResult>, keys_img: Res<KeysTextureAtlas>, mut commands: Commands) {
    let guess_result = result.0.clone();
    let total_width = MULTIPLIER * (5 as f32 - 1.0);
    let start_x = -total_width / 2.0;

    for (i, status) in guess_result.iter().enumerate() {
        let texture_index: usize;

        match status {
            LetterStatus::Grey => texture_index = 6,
            LetterStatus::Yellow => texture_index = 7,
            LetterStatus::Green => texture_index = 8,
        }

        let x = start_x + (i as f32 * MULTIPLIER);

        let keys_sprite = SpriteBundle {
            transform: Transform::from_translation(Vec3::new(
                // x * MULTIPLIER,
                x,
                ((0) as f32) * MULTIPLIER,
                COLOR_HEIGHT,
            ))
            .with_scale(SCALE),
            texture: keys_img.texture.clone(),
            ..default()
        };
        let color_texture = TextureAtlas {
            layout: keys_img.layout.clone(),
            index: texture_index,
        };

        commands.spawn((keys_sprite, color_texture, ColorImage));
    }
}

fn remove_old_colors(query: Query<Entity, With<ColorImage>>, mut commands: Commands) {
    for entity in query.iter() {
        commands.entity(entity).despawn();
    }
}

fn reset_colors(mut result: ResMut<GuessResult>) {
    result.0 = vec![
        LetterStatus::Grey,
        LetterStatus::Grey,
        LetterStatus::Grey,
        LetterStatus::Grey,
        LetterStatus::Grey,
    ];
}
