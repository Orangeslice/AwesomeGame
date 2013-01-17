class BomberAI extends AwesomeAIController;

// Dynamic light environment component to help speed up lighting calculations for the pawn
var const DynamicLightEnvironmentComponent LightEnvironment;
// Explosion particle system to play when blowing up
var const ParticleSystem ExplosionParticleTemplate;
// Explosion sound to play
var const SoundCue ExplosionSoundCue;

var float DamageRadius;

function Attack()
{
    HurtRadius(WeaponDamage, DamageRadius, class'AwesomeGame.BomberDamage', 10, pawn.location);
    Pawn.Destroy();
}

defaultproperties
{
    AttackDistance = 200
    WeaponDamage = 300
    DamageRadius = 300
}