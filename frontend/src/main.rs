use bevy::{asset::AssetMetaCheck, prelude::*};
use frontend::GamePlugin;

fn main() {
    let mut app = App::new();
    app.add_plugins(
        DefaultPlugins
            .set(WindowPlugin {
                primary_window: Some(Window {
                    title: "CrossWordle".to_string(), // ToDo
                    // Bind to canvas included in `index.html`
                    canvas: Some("#bevy".to_owned()),
                    fit_canvas_to_parent: false,
                    // Tells wasm not to override default event handling, like F5 and Ctrl+R
                    prevent_default_event_handling: false,
                    ..default()
                }),
                ..default()
            })
            .set(AssetPlugin {
                meta_check: AssetMetaCheck::Never,
                ..default()
            })
            .set(ImagePlugin::default_nearest()),
    );

    app.add_plugins(GamePlugin);
    app.run();
}
