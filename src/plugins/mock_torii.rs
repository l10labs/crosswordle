use bevy::prelude::*;
use rand::Rng;

use crate::manual_bindgen::{Letter, LetterColor};

use super::game_states::GameStates;

pub struct ToriiPlugin;
impl Plugin for ToriiPlugin {
    fn build(&self, app: &mut App) {
        // app.add_systems(
        //     Update,
        //     (clear_words, generate_word_entities, display_words)
        //         .chain()
        //         .run_if(input_just_pressed(KeyCode::Space)),
        // );
        app.add_systems(
            OnEnter(GameStates::WordleNew),
            (clear_words, generate_word_entities, display_words).chain(),
        );
    }
}

fn generate_word_entities(mut commands: Commands) {
    let random_5_letter_words = [
        "acorn", "amber", "apple", "aroma", "beach", "blaze", "bride", "broom", "candy", "chime",
        "cloud", "crave", "daisy", "dough", "drape", "dwarf", "eagle", "eerie", "elbow", "ember",
        "fairy", "flaky", "flute", "frown", "giant", "glide", "goofy", "grape", "happy", "hazel",
        "hiker", "hound", "ideal", "igloo", "image", "ivory", "jazzy", "jelly", "joker", "jumbo",
        "karma", "kites", "kitty", "koala", "lapse", "lemon", "llama", "lucky", "mango", "maple",
        "mirth", "moose", "night", "ninja", "noble", "nudge", "oasis", "ocean", "olive", "onion",
        "panda", "peach", "pizza", "plume", "quilt", "quick", "quiet", "queen", "razor", "rhyme",
        "river", "robin", "spicy", "storm", "sunny", "swirl", "tango", "tiger", "torch", "tulip",
        "ultra", "umbra", "unity", "usher", "viper", "vivid", "voice", "vowel", "wacky", "wagon",
        "waltz", "whale", "xenon", "yacht", "yield", "youth", "yummy", "zesty", "zonal", "zebra",
    ];

    // random number between 0 and 25:
    let random_index = rand::thread_rng().gen_range(0..26);

    let word = random_5_letter_words[random_index];

    for (index, letter) in word.chars().enumerate() {
        let letter = Letter {
            position: index as u8,
            is_user_guess: false,
            value: letter.clone(),
        };

        let color = LetterColor {
            position: index as u8,
            color: 0, // The color is gray by default
        };

        commands.spawn((letter, color));
    }
}

fn clear_words(mut commands: Commands, query: Query<(Entity, &Letter, &LetterColor)>) {
    for (entity, _, _) in query.iter() {
        commands.entity(entity).despawn();
    }
}

fn display_words(query: Query<(&Letter, &LetterColor)>) {
    for (letter, color) in query.iter() {
        info!("Letter: {:?}, Color: {:?}", letter.value, color);
    }
}
