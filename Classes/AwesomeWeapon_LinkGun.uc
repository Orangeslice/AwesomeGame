class AwesomeWeapon_LinkGun extends AwesomeWeapon
    placeable;

simulated function Projectile ProjectileFire()
{
    local Projectile MyProj;
    MyProj = super.ProjectileFire();
    MyProj.Damage = CurrentWeaponLevel * 1;
    return MyProj;
}

simulated function UpgradeWeapon()
{
    super.UpgradeWeapon();
    FireInterval[0] = 0.05;
}
    
defaultproperties
{
    Begin Object Name=PickupMesh
        SkeletalMesh=SkeletalMesh'WP_LinkGun.Mesh.SK_WP_LinkGun_3P'
    End Object
    AttachmentClass=class'UTGame.UTAttachment_Linkgun'
    WeaponFireTypes(0)=EWFT_Projectile
    WeaponFireTypes(1)=EWFT_Projectile
    WeaponProjectiles(0)=class'UTProj_LinkPlasma'
    AmmoCount=100
    MaxAmmoCount=100
    CurrentWeaponLevel = 1
    FireInterval[0] = 0.05
}