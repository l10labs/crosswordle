use bevy::{asset::AssetMetaCheck, prelude::*};
use plugins::{
    cursor::CursorPlugin, guess_letter::GuessLetterPlugin, image_visualize::VisualizeImagePlugin,
    mock_torii::ToriiPlugin, solution_verifier::SolutionVerifierPlugin,
    switch_letter_status::FlipLetterStatusPlugin,
};
pub mod plugins;

fn main() {
    let mut app = App::new();

    app.add_plugins(
        DefaultPlugins
            .set(WindowPlugin {
                primary_window: Some(Window {
                    // provide the ID selector string here
                    canvas: Some("#crosswordle".into()),
                    // ... any other window properties ...
                    ..default()
                }),
                ..default()
            })
            .set(ImagePlugin::default_nearest()),
    );
    app.add_systems(Startup, default_camera);
    app.add_plugins(ToriiPlugin);
    app.add_plugins(VisualizeImagePlugin);
    app.add_plugins(FlipLetterStatusPlugin);
    app.add_plugins(CursorPlugin);
    app.add_plugins(GuessLetterPlugin);
    app.add_plugins(SolutionVerifierPlugin);

    app.run();
}

fn default_camera(mut commands: Commands) {
    let mut camera_bundle = Camera2dBundle::default();
    camera_bundle.projection.scale = 0.3;
    commands.spawn(camera_bundle);
}

fn display_entity_count(query: Query<Entity>) {
    let mut total = 0;
    for _entity in query.iter() {
        total += 1;
    }
    info!("Total entities: {}", total);
}
