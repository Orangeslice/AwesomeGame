class MinionAI extends AwesomeAIController;

simulated function Attack()
{
    local UTProj_LinkPlasma MyProj;
        if(!bAttacking)
        {
            bAttacking = true;
            MyProj = spawn(class'UTProj_LinkPlasma', self,,Pawn.Location);
            MyProj.Damage = WeaponDamage;
            MyProj.Init(normal(target.Location - Pawn.Location));
            SetTimer(0.05,false,'EndAttack');
        }
    super.Attack();
}

defaultproperties
{
    WeaponDamage = 5
}