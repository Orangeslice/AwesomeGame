class TestEnemyMinion extends TestEnemy;

    function RunAway()
    {
        GoToState('Fleeing');
    }

    event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
    {
        if(AwesomeGame(WorldInfo.Game) != none) AwesomeGame(WorldInfo.Game).EnemyKilled();
        if(Rand(2) == 1) spawn(class'AwesomeWeaponUpgrade',,, Location);
        Destroy();
    }

defaultproperties
{
    
}