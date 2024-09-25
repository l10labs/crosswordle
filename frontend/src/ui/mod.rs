use bevy::prelude::*;

use crate::plugins::{constants::LOGO_SCALE, game_states::GameStates};

pub struct GameUiPlugin;
impl Plugin for GameUiPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(OnEnter(GameStates::StartGame), display_start_screen);
        app.add_systems(OnExit(GameStates::StartGame), remove_start_screen);
        app.add_systems(OnEnter(GameStates::WordleNew), display_enter_ui);
        app.add_systems(OnExit(GameStates::WordleNew), remove_start_screen);
        app.add_systems(OnEnter(GameStates::WordleSolved), display_submit_ui);
        app.add_systems(OnExit(GameStates::WordleSolved), remove_start_screen);
    }
}

#[derive(Debug, Component)]
struct StartScreenImage;

fn display_start_screen(mut commands: Commands, asset_server: Res<AssetServer>) {
    let image_color = Color::linear_rgb(154., 165., 171.);
    commands.spawn((
        SpriteBundle {
            texture: asset_server.load("ui/ui3.png"),
            transform: Transform::from_xyz(0., -30., 0.),
            sprite: Sprite {
                color: image_color,
                ..default()
            },
            ..default()
        },
        StartScreenImage,
    ));

    commands.spawn((
        SpriteBundle {
            texture: asset_server.load("ui/final_cw_logo.png"),
            transform: Transform::from_xyz(0., 10., 0.).with_scale(LOGO_SCALE),
            ..default()
        },
        StartScreenImage,
    ));
}

fn display_enter_ui(mut commands: Commands, asset_server: Res<AssetServer>) {
    let image_color = Color::linear_rgb(154., 165., 171.);
    commands.spawn((
        SpriteBundle {
            texture: asset_server.load("ui/ui1.png"),
            transform: Transform::from_xyz(0., -30., 0.),
            sprite: Sprite {
                color: image_color,
                ..default()
            },
            ..default()
        },
        StartScreenImage,
    ));
}

fn display_submit_ui(mut commands: Commands, asset_server: Res<AssetServer>) {
    let image_color = Color::linear_rgb(154., 165., 171.);
    commands.spawn((
        SpriteBundle {
            texture: asset_server.load("ui/ui2.png"),
            transform: Transform::from_xyz(0., -30., 0.),
            sprite: Sprite {
                color: image_color,
                ..default()
            },
            ..default()
        },
        StartScreenImage,
    ));
}

fn remove_start_screen(query: Query<Entity, With<StartScreenImage>>, mut commands: Commands) {
    for entity in query.iter() {
        commands.entity(entity).despawn();
    }
}
