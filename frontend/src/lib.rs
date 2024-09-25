pub mod manual_bindgen;
pub mod plugins;
pub mod ui;

use bevy::{input::common_conditions::input_just_pressed, prelude::*};
use plugins::{
    game_states::GameStatesPlugin, guess::GuessPlugin, mock_torii::ToriiPlugin,
    set_color::SetColorPlugin, visualize::VisualizeImagePlugin,
};
use ui::GameUiPlugin;

pub struct GamePlugin;
impl Plugin for GamePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Startup, default_camera);
        app.add_plugins(ToriiPlugin);
        app.add_plugins(VisualizeImagePlugin);
        app.add_plugins(GuessPlugin);
        app.add_plugins(SetColorPlugin);
        app.add_plugins(GameStatesPlugin);
        app.add_plugins(GameUiPlugin);
        app.add_systems(
            Update,
            display_entity_count.run_if(input_just_pressed(KeyCode::Tab)),
        );
    }
}

fn default_camera(mut commands: Commands) {
    let mut camera_bundle = Camera2dBundle::default();
    camera_bundle.projection.scale = 0.15;
    commands.spawn(camera_bundle);
}

fn display_entity_count(query: Query<Entity>) {
    let mut total = 0;
    for _entity in query.iter() {
        total += 1;
    }
    info!("Total entities: {}", total);
}
