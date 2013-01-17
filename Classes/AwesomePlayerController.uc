class AwesomePlayerController extends UTPlayerController;

var vector PlayerViewOffset, CurrentCameraLocation, DesiredCameraLocation, PlaneHitPos;
var rotator CurrentCameraRotation;
var rotator FaceRot;

//Set Stuff Up
simulated function PostBeginPlay()
{
    super.PostBeginPlay();
}

//Update Rotation to Mouse Position
function UpdateRotation(float DeltaTime)
{
    local Vector Mouse3DCoords;
    
    Mouse3DCoords = AwesomeHUD(MyHUD).MouseWorldLocation;
    
    FaceRot = Rotator(Mouse3DCoords - Pawn.Weapon.GetMuzzleLoc()); // GetMuzzleLoc - This function returns the world location for spawning the visual effects
    Pawn.FaceRotation(FaceRot, DeltaTime);
}

//Set Camera Rotation
simulated event GetPlayerViewPoint(out vector out_Location, out Rotator out_Rotation)
{
    super.GetPlayerViewPoint(out_Location, out_Rotation);
    if(Pawn != none)
    {
        out_Location = CurrentCameraLocation;
        out_Rotation = rotator((out_Location * vect(1,1,0)) - out_Location);
    }
    CurrentCameraRotation = out_Rotation;
}

//Update Camera Location
function PlayerTick(float DeltaTime)
{
    super.PlayerTick(DeltaTime);
    if(Pawn != none)
    {
        DesiredCameraLocation = Pawn.Location + (PlayerViewOffset >> Pawn.Rotation);
        CurrentCameraLocation += (DesiredCameraLocation - CurrentCameraLocation) * DeltaTime * 3;
    }
}

//Override Player Walking Controls
state PlayerWalking
{
    function ProcessMove(float DeltaTime, vector newAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
    {
        local vector X, Y, Z, AltAccel;
        GetAxes(CurrentCameraRotation, X, Y, Z);
        AltAccel = PlayerInput.aForward * Z + PlayerInput.aStrafe * Y;
        AltAccel.Z = 0;
        AltAccel = Pawn.AccelRate * Normal(AltAccel);
        super.ProcessMove(DeltaTime, AltAccel, DoubleClickMove, DeltaRot);
    }
}

//Adjust Pawn's Aim
function Rotator GetAdjustedAimFor(Weapon W, Vector StartFireLoc)
{
    return Pawn.Rotation;
}

//Make me invisible when I have a Rocket Launcher
function NotifyChangedWeapon(Weapon PrevWeapon, Weapon NewWeapon)
{
    super.NotifyChangedWeapon(PrevWeapon, NewWeapon);
    NewWeapon.SetHidden(true);
    if(Pawn == none) return;
    if(UTWeap_RocketLauncher(NewWeapon) != none) Pawn.SetHidden(true);
    else Pawn.SetHidden(false);
}

//Make me appear when firing
exec function StartFire( optional byte FireModeNum )
{
    super.StartFire(FireModeNum);
    if(Pawn != none && UTWeap_RocketLauncher(Pawn.Weapon) !=none)
    {
        Pawn.SetHidden(false);
        SetTimer(1, false, 'MakeMeInvisible');
    }
}

//Make Pawn Invisible
function MakeMeInvisible()
{
    if(Pawn != none && UTWeap_RocketLauncher(Pawn.Weapon) != none) Pawn.SetHidden(true);
}

defaultproperties
{
    PlayerViewOffset=(X=30,Y=30,Z=512)
    InputClass=class'MouseInterfacePlayerInput'
}