use bevy::{prelude::*, utils::HashMap};

use crate::manual_bindgen::{Letter, LetterColor};

use super::constants::{HIDDEN_INDEX, MULTIPLIER, SCALE};

pub struct VisualizeImagePlugin;
impl Plugin for VisualizeImagePlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Startup, build_letter_to_image_map);
        app.add_systems(Startup, create_texture_atlas);
        app.init_state::<VisualStates>();
        app.add_systems(Update, check_if_ready.run_if(in_state(VisualStates::Start)));
        app.add_systems(
            Update,
            spawn_tile_background.run_if(in_state(VisualStates::RenderInitTileBackground)),
        );
    }
}

#[derive(States, Default, Debug, Clone, PartialEq, Eq, Hash)]
enum VisualStates {
    #[default]
    Start,
    RenderInitTileBackground,
    RenderLetters,
    End,
}

#[derive(Debug, Resource)]
struct KeysTextureAtlas {
    texture: Handle<Image>,
    layout: Handle<TextureAtlasLayout>,
}

#[derive(Debug, Resource)]
struct LetterTextureAtlas {
    texture: Handle<Image>,
    layout: Handle<TextureAtlasLayout>,
}

fn create_texture_atlas(
    asset_server: Res<AssetServer>,
    mut texture_atlas_layouts: ResMut<Assets<TextureAtlasLayout>>,
    mut commands: Commands,
) {
    let keys_texture: Handle<Image> = asset_server.load("new_keys.png");
    let keys_layout = TextureAtlasLayout::from_grid(UVec2::new(15, 16), 6, 2, None, None);
    commands.insert_resource(KeysTextureAtlas {
        texture: keys_texture,
        layout: texture_atlas_layouts.add(keys_layout),
    });

    let letter_texture: Handle<Image> = asset_server.load("letters_only.png");
    let letter_layout = TextureAtlasLayout::from_grid(UVec2::new(15, 16), 5, 8, None, None);
    commands.insert_resource(LetterTextureAtlas {
        texture: letter_texture,
        layout: texture_atlas_layouts.add(letter_layout),
    });
}

fn check_if_ready(
    query: Query<(&Letter, &LetterColor)>,
    mut next_render_state: ResMut<NextState<VisualStates>>,
) {
    if query.iter().count() == 5 {
        next_render_state.set(VisualStates::RenderInitTileBackground);
    }
}

fn spawn_tile_background(
    mut commands: Commands,
    keys_img: Res<KeysTextureAtlas>,
    mut next_render_state: ResMut<NextState<VisualStates>>,
    query: Query<(&Letter, &LetterColor)>,
) {
    let spacing = 20.0; // Adjust this value to change the spacing between sprites
    let total_width = spacing * (5 as f32 - 1.0);
    let start_x = -total_width / 2.0;

    for (letter, _letter_status) in query.iter() {
        let x = start_x + (letter.position as f32 * spacing);
        // let letter_value = letter.value.clone().to_string();
        let keys_sprite = SpriteBundle {
            transform: Transform::from_translation(Vec3::new(
                // x * MULTIPLIER,
                x,
                ((0) as f32) * MULTIPLIER,
                1.,
            ))
            .with_scale(SCALE),
            texture: keys_img.texture.clone(),
            ..default()
        };
        let hidden_texture = TextureAtlas {
            layout: keys_img.layout.clone(),
            index: HIDDEN_INDEX,
        };

        commands.spawn((keys_sprite, hidden_texture));
    }
    next_render_state.set(VisualStates::RenderLetters);
}

// fn spawn_default_sprite(
//     mut commands: Commands,
//     query: Query<(Entity, &Letter, &LetterColor), Without<ImageVisual>>,
//     letter_map: Res<LetterMap>,
//     keys_img: Res<KeysTextureAtlas>,
//     letters_img: Res<LetterTextureAtlas>,
// ) {
//     for (entity_id, letter, _letter_status) in query.iter() {
//         let letter_value = letter.mock_hash.clone().to_string();
//         let keys_sprite = SpriteBundle {
//             transform: Transform::from_translation(Vec3::new(
//                 ((letter.position) as f32) * MULTIPLIER,
//                 ((0) as f32) * MULTIPLIER,
//                 1.,
//             ))
//             .with_scale(SCALE),
//             texture: keys_img.texture.clone(),
//             ..default()
//         };
//         let hidden_texture = TextureAtlas {
//             layout: keys_img.layout.clone(),
//             index: HIDDEN_INDEX,
//         };

//         let letters_sprite = SpriteBundle {
//             transform: Transform::from_translation(Vec3::new(
//                 ((letter.position) as f32) * MULTIPLIER,
//                 ((0) as f32) * MULTIPLIER,
//                 0.,
//             ))
//             .with_scale(SCALE),
//             texture: letters_img.texture.clone(),
//             ..default()
//         };
//         let letter_index = letter_map.map.get(letter_value.as_str()).unwrap().clone() as usize;

//         let solved_texture = TextureAtlas {
//             layout: letters_img.layout.clone(),
//             index: letter_index,
//         };

//         let parent_entity = ParentEntity(entity_id);

//         commands.spawn((keys_sprite, hidden_texture, parent_entity.clone(), KeyLayer));
//         commands.spawn((letters_sprite, solved_texture, parent_entity, LetterLayer));

//         commands.entity(entity_id).insert((ImageVisual {
//             hidden: HIDDEN_INDEX,
//             solved: letter_index,
//         },));
//     }
// }

#[derive(Debug, Resource)]
pub struct LetterHashMap {
    pub map: HashMap<&'static str, u8>,
}

fn build_letter_to_image_map(mut commands: Commands) {
    let hashmap: HashMap<&str, u8> = [
        ("a", 0),
        ("b", 1),
        ("c", 2),
        ("d", 3),
        ("e", 4),
        ("f", 5),
        ("g", 6),
        ("h", 7),
        ("i", 8),
        ("j", 9),
        ("k", 10),
        ("l", 11),
        ("m", 12),
        ("n", 13),
        ("o", 14),
        ("p", 15),
        ("q", 16),
        ("r", 17),
        ("s", 18),
        ("t", 19),
        ("u", 20),
        ("v", 21),
        ("w", 22),
        ("x", 23),
        ("y", 24),
        ("z", 25),
        ("up", 26),
        ("right", 27),
        ("down", 28),
        ("left", 29),
        ("1", 30),
        ("2", 31),
        ("3", 32),
        ("4", 33),
        ("5", 34),
        ("6", 35),
        ("7", 36),
        ("8", 37),
        ("9", 38),
        ("0", 39),
    ]
    .into();

    commands.insert_resource(LetterHashMap { map: hashmap });
}
