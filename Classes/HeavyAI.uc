class HeavyAI extends AwesomeAIController;

simulated function Attack()
{
        local UTProj_Rocket MyRocket;
        if(!bAttacking)
        {
            bAttacking = true;
            MyRocket = spawn(class'UTProj_Rocket', self,,Pawn.Location);
            MyRocket.Damage = WeaponDamage;
            MyRocket.Init(normal(target.Location - Pawn.Location));
            SetTimer(1,false,'EndAttack');
        }
    super.Attack();
}

defaultproperties
{
    
}