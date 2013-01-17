class AwesomeWeapon extends UTWeapon
    abstract;

var int CurrentWeaponLevel;

function UpgradeWeapon()
{
    CurrentWeaponLevel++;
    //FireInterval[0] = 2/(CurrentWeaponLevel+1);
    AddAmmo(MaxAmmoCount);
    //MaxAmmoCount = (CurrentWeaponLevel / 2) * 4;
}

function ReloadWeapon()
{
    AddAmmo(MaxAmmoCount);
}

defaultproperties
{
}