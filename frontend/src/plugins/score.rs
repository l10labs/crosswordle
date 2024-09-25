use bevy::prelude::*;

pub struct ScorePlugin;
impl Plugin for ScorePlugin {
    fn build(&self, app: &mut App) {}
}

#[derive(Debug, Component)]
pub struct LetterPrize(pub char);
