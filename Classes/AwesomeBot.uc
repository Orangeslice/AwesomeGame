class AwesomeBot extends UDKPawn
    abstract;

//Variables    
var() string TestVar;
var int MaxHealth,MyHealth,ScoreValue;

//Set up Stuff
event PostBeginPlay()
{
    super.PostBeginPlay();
    `log("********************BOT LOADED*******");
    SpawnDefaultController();
    AddDefaultInventory();
    MyHealth = MaxHealth;
    SetPhysics(PHYS_Walking);
} 
/*
//sets ragdoll physics
simulated function SetPawnRBChannels(bool bRagdollMode)
{
    Mesh.SetRBChannel((bRagdollMode) ? RBCC_Pawn : RBCC_Untitled3);
    Mesh.SetRBCollidesWithChannel(RBCC_Default, bRagdollMode);
    Mesh.SetRBCollidesWithChannel(RBCC_Pawn, bRagdollMode);
    Mesh.SetRBCollidesWithChannel(RBCC_Vehicle, bRagdollMode);
    Mesh.SetRBCollidesWithChannel(RBCC_Untitled3, !bRagdollMode);
    Mesh.SetRBCollidesWithChannel(RBCC_BlockingVolume, bRagdollMode);
}  

//function called for death
simulated function PlayDying(class<DamageType> DamageType, vector HitLoc)
{
    local DroppedPickup DroppedPickup;

    Mesh.MinDistFactorForKinematicUpdate = 0.0;
    Mesh.ForceSkelUpdate();
    Mesh.SetTickGroup(TG_PostAsyncWork);
    CollisionComponent = Mesh;
    CylinderComponent.SetActorCollision(false, false);
    Mesh.SetActorCollision(true, false);
    Mesh.SetTraceBlocking(true, true);
    SetPawnRBChannels(true);
    SetPhysics(PHYS_RigidBody);
    Mesh.PhysicsWeight = 1.f;

    if (Mesh.bNotUpdatingKinematicDueToDistance)
    {
        Mesh.UpdateRBBonesFromSpaceBases(true, true);
    }

    Mesh.PhysicsAssetInstance.SetAllBodiesFixed(false);
    Mesh.bUpdateKinematicBonesFromAnimation = false;
    Mesh.WakeRigidBody();

    // Set the actor to automatically destroy in ten seconds.
    LifeSpan = 10.f;

    // Chance to drop a pick up
    /*
    if (ArchetypedPickup != None && FRand() <= ChanceToDropPickup)
    {
        // Spawn a dropped pickup
        DroppedPickup = Spawn(ArchetypedPickup.Class,,, Location,, ArchetypedPickup);
        if (DroppedPickup != None)
        {
            // Set the dropped pick up to falling
            DroppedPickup.SetPhysics(PHYS_Falling);
            // Set the velocity of the dropped pickup to the toss velocity
            DroppedPickup.Velocity.X = 0;
            DroppedPickup.Velocity.Y = 0;
            DroppedPickup.Velocity.Z = RandRange(200.f, 250.f);
        }
    }
    */
}
*/

//Create Inventory   
function AddDefaultInventory()
{
    //InvManager.CreateInventory(class'AwesomeGame.AwesomeWeapon_RocketLauncher');
}

//Handle Damaage Taken
event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
    {
        MyHealth -= DamageAmount;
        if(MyHealth <= 0)
        {
            if(EventInstigator != none && EventInstigator.PlayerReplicationInfo != none)
            {
            if(AwesomeGame(WorldInfo.Game) != none) AwesomeGame(WorldInfo.Game).EnemyKilled();
            //WorldInfo.Game.ScoreObjective(EventInstigator.PlayerReplicationInfo, 1);
            if(Rand(2) == 0)
            {
                spawn(class'AwesomeWeaponUpgrade',,, Location);
            }
            else
            {
                spawn(class'AwesomeHealthPack',,, Location);
            }
            }
            //PlayDying(DamageType, HitLocation);
            AwesomeGame(WorldInfo.Game).AddScore(ScoreValue);
            Destroy();
        }
    }
    
defaultproperties
{
    Begin Object Name=CollisionCylinder
        CollisionHeight=+44.000000
    End Object
 
    bJumpCapable=false
    bCanJump=false
 
    GroundSpeed=200.0 //Making the bot slower than the player
    
    MaxHealth = 40 //Set the starting health for the enemy
    
    ScoreValue = 100
}