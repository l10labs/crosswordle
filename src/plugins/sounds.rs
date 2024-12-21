use bevy::{input::common_conditions::input_just_pressed, prelude::*};
use bevy_kira_audio::prelude::*;

use super::game_states::GameStates;

pub struct SoundPlugin;
impl Plugin for SoundPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins(AudioPlugin);
        app.add_systems(Startup, background_music_looped);
        app.add_systems(Startup, win_word);
        app.add_systems(
            Update,
            play_click_sound.run_if(input_just_pressed(KeyCode::Escape)),
        );
        app.add_systems(OnEnter(GameStates::WordleNew), play_click_sound);
        app.add_systems(OnEnter(GameStates::WordleSolved), win_word);
    }
}

fn background_music_looped(asset_server: Res<AssetServer>, audio: Res<Audio>) {
    audio
        .play(asset_server.load("sounds/crosswordle_music.wav"))
        .with_volume(0.3)
        .looped();
}

fn play_click_sound(asset_server: Res<AssetServer>, audio: Res<Audio>) {
    audio.play(asset_server.load("sounds/pluck.wav"));
}

fn win_word(asset_server: Res<AssetServer>, audio: Res<Audio>) {
    audio.play(asset_server.load("sounds/sucess_word_1.wav"));
}
