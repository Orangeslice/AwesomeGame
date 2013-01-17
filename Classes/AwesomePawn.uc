class AwesomePawn extends UTPawn;

var bool bInvulnerable;
var float InvulnerableTime;

//Set Initial Stuff Up
simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    if(ArmsMesh[0] !=none) ArmsMesh[0].SetHidden(true);
    if(ArmsMesh[1] != none) ArmsMesh[1].SetHidden(true);
}

//Take Damage from Melee
event Bump(Actor Other, PrimitiveComponent OtherComp, vector HitNormal)
{
    if(TestEnemy(Other) != none && !bInvulnerable)
    {
        bInvulnerable = true;
        SetTimer(InvulnerableTime, false, 'EndInvulnerable');
        TakeDamage(TestEnemy(Other).BumpDamage, none, Location, vect(0,0,0), class'UTDmgType_LinkPlasma');
    }
}


simulated function vector GetAimStartLocation()
{
    local vector PawnAimLocation;
    
    if (Weapon != none)
    {
        pawnAimLocation = Location + vect(0,0,1) * (Weapon.GetPhysicalFireStartLoc().Z - Location.Z); //use the upvector
        return PawnAimLocation;
    }
    else
    {
        return GetPawnViewLocation();//eye fallback
    }
}

//End Invulnerability
function EndInvulnerable()
{
    bInvulnerable = false;
}

//Receive HealthPacks
function HealthPack()
{
    GiveHealth(10,100);
}

//Set Invisibility
simulated function SetMeshVisibility(bool bVisible)
{
    super.SetMeshVisibility(bVisible);
    Mesh.SetOwnerNoSee(false);
}

defaultproperties
{
    InvulnerableTime=0.6 //Invulnerability Timer
     Begin Object Class=SkeletalMeshComponent Name=PawnSkeletalMeshComponent
         
       //Your Mesh Properties
      SkeletalMesh=SkeletalMesh'CH_LIAM_Cathode.Mesh.SK_CH_LIAM_Cathode'
      AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
      PhysicsAsset=PhysicsAsset'CH_AnimCorrupt.Mesh.SK_CH_Corrupt_Male_Physics'
      AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
      Translation=(Z=8.0)
      Scale=1.075
      
      //General Mesh Properties
      bCacheAnimSequenceNodes=FALSE
      AlwaysLoadOnClient=true
      AlwaysLoadOnServer=true
      bOwnerNoSee=false
      CastShadow=true
      BlockRigidBody=TRUE
      bUpdateSkelWhenNotRendered=false
      bIgnoreControllersWhenNotRendered=TRUE
      bUpdateKinematicBonesFromAnimation=true
      bCastDynamicShadow=true
      RBChannel=RBCC_Untitled3
      RBCollideWithChannels=(Untitled3=true)
      LightEnvironment=MyLightEnvironment
      bOverrideAttachmentOwnerVisibility=true
      bAcceptsDynamicDecals=FALSE
      bHasPhysicsAssetInstance=true
      TickGroup=TG_PreAsyncWork
      MinDistFactorForKinematicUpdate=0.2
      bChartDistanceFactor=true
      RBDominanceGroup=20
      bUseOnePassLightingOnTranslucency=TRUE
      bPerBoneMotionBlur=true
   End Object
   Mesh=PawnSkeletalMeshComponent
   Components.Add(PawnSkeletalMeshComponent)
   CamOffset=(X=10.0,Y=16,Z=-13.0)
}