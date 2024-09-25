use bevy::{input::common_conditions::input_just_pressed, prelude::*};

use crate::manual_bindgen::Letter;

pub struct SetColorPlugin;
impl Plugin for SetColorPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(
            Update,
            check_guess.run_if(input_just_pressed(KeyCode::Enter)),
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

fn check_guess(query: Query<&Letter>, mut commands: Commands) {
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

        let result = compare_guess(&answer, &guess);

        info!("Guess Result: {:?}", result);
        commands.insert_resource(GuessResult(result));
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
