// use bevy::{prelude::*, utils::HashMap};

// pub struct VisualizeImagePlugin;
// impl Plugin for VisualizeImagePlugin {
//     fn build(&self, app: &mut App) {
//         app.add_systems(Startup, build_letter_to_image_map);
//         app.add_systems(Startup, create_texture_atlas);
//     }
// }

// #[derive(Debug, Resource)]
// struct KeysTextureAtlas {
//     texture: Handle<Image>,
//     layout: Handle<TextureAtlasLayout>,
// }

// #[derive(Debug, Resource)]
// struct LetterTextureAtlas {
//     texture: Handle<Image>,
//     layout: Handle<TextureAtlasLayout>,
// }

// fn create_texture_atlas(
//     asset_server: Res<AssetServer>,
//     mut texture_atlas_layouts: ResMut<Assets<TextureAtlasLayout>>,
//     mut commands: Commands,
// ) {
//     let keys_texture: Handle<Image> = asset_server.load("new_keys.png");
//     let keys_layout = TextureAtlasLayout::from_grid(UVec2::new(15, 16), 6, 2, None, None);
//     commands.insert_resource(KeysTextureAtlas {
//         texture: keys_texture,
//         layout: texture_atlas_layouts.add(keys_layout),
//     });

//     let letter_texture: Handle<Image> = asset_server.load("letters_only.png");
//     let letter_layout = TextureAtlasLayout::from_grid(UVec2::new(15, 16), 5, 8, None, None);
//     commands.insert_resource(LetterTextureAtlas {
//         texture: letter_texture,
//         layout: texture_atlas_layouts.add(letter_layout),
//     });
// }

// #[derive(Debug, Resource)]
// pub struct LetterHashMap {
//     pub map: HashMap<&'static str, u8>,
// }

// fn build_letter_to_image_map(mut commands: Commands) {
//     let hashmap: HashMap<&str, u8> = [
//         ("a", 0),
//         ("b", 1),
//         ("c", 2),
//         ("d", 3),
//         ("e", 4),
//         ("f", 5),
//         ("g", 6),
//         ("h", 7),
//         ("i", 8),
//         ("j", 9),
//         ("k", 10),
//         ("l", 11),
//         ("m", 12),
//         ("n", 13),
//         ("o", 14),
//         ("p", 15),
//         ("q", 16),
//         ("r", 17),
//         ("s", 18),
//         ("t", 19),
//         ("u", 20),
//         ("v", 21),
//         ("w", 22),
//         ("x", 23),
//         ("y", 24),
//         ("z", 25),
//         ("up", 26),
//         ("right", 27),
//         ("down", 28),
//         ("left", 29),
//         ("1", 30),
//         ("2", 31),
//         ("3", 32),
//         ("4", 33),
//         ("5", 34),
//         ("6", 35),
//         ("7", 36),
//         ("8", 37),
//         ("9", 38),
//         ("0", 39),
//     ]
//     .into();

//     commands.insert_resource(LetterHashMap { map: hashmap });
// }
