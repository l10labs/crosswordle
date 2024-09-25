use bevy::{
    input::{
        keyboard::{Key, KeyboardInput},
        ButtonState,
    },
    prelude::*,
};

pub struct GuessPlugin;
impl Plugin for GuessPlugin {
    fn build(&self, app: &mut App) {
        app.add_systems(Startup, init_position);
        app.add_systems(Update, input_letter_guess);
    }
}

// Define a resource to keep track of the current position
#[derive(Resource)]
struct CursorPosition(u8);

// // System to spawn letters when keys are pressed
// fn spawn_letter_system(
//     mut commands: Commands,
//     mut current_position: ResMut<CursorPosition>,
//     keyboard_input: Res<Input<KeyCode>>,
// ) {
//     for key in keyboard_input.get_just_pressed() {
//         if let Some(char_value) = key_to_char(key) {
//             commands.spawn(Letter {
//                 position: current_position.0,
//                 is_user_guess: true,
//                 value: char_value,
//             });

//             // Increment the current position
//             current_position.0 += 1;
//         }
//     }
// }

fn init_position(mut commands: Commands) {
    commands.insert_resource(CursorPosition(0));
}

fn input_letter_guess(
    mut evr_kbd: EventReader<KeyboardInput>,
    // mut cursor_position: ResMut<CursorPosition>,
    // mut letter_guess_query: Query<&mut LetterGuess>,
) {
    for ev in evr_kbd.read() {
        if ev.state == ButtonState::Released {
            continue;
        }
        match &ev.logical_key {
            Key::Character(c) => {
                let upper_a: u32 = 'A'.into();
                let upper_z: u32 = 'Z'.into();
                let lower_a: u32 = 'a'.into();
                let lower_z: u32 = 'z'.into();
                let char_code: u32 = c.chars().next().unwrap().into();

                if (char_code >= lower_a && char_code <= lower_z)
                    || (char_code >= upper_a && char_code <= upper_z)
                {
                    println!("Typed: {}", c);
                    // if letter.letters.len() < 5 {
                    //     letter.letters.push(c.to_lowercase().to_string());
                    // } else {
                    //     println!("Already typed 5 letters!");
                    // }
                } else {
                    println!("Invalid character: {}", c);
                }
            }
            // Key::Backspace => {
            //     if !letter.letters.is_empty() {
            //         letter.letters.pop();
            //     }
            // }
            _ => {}
        }
    }
}
