class AwesomeBoss extends TestEnemy;

var int Health;
var int MaxHealth;

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    Health = MaxHealth;
}

auto state Seeking
{
    function BeginState(Name PreviousStateName)
    {
        SetTimer(4.0, true, 'Attack');
    }
    
    function Attack()
    {
        spawn(class'TestEnemyMinion',,,Location);
        SetMaterial(AttackingMat);
        SetTimer(1, false, 'EndAttack');
    }
    
    function Tick(float DeltaTime)
    {
        local vector NewLocation;
        if(Enemy == none) GetEnemy();
        if(Enemy != none)
        {
            NewLocation = Location;
            NewLocation += normal(Enemy.Location - Location) * MovementSpeed * DeltaTime;
            NewLocation += normal((Enemy.Location - Location) cross vect(0,0,1)) * MovementSpeed * DeltaTime;
            SetLocation(NewLocation);
        }
    }
}

state RageMode extends Seeking
{
    function BeginState(name PreviousState)
    {
        SeekingMat = FleeingMat;
        SetMaterial(SeekingMat);
    }
    function Attack()
    {
        local UTProj_Rocket MyRocket;
        //super.Attack();
        MyRocket = spawn(class'UTProj_Rocket', self,,Location);
        MyRocket.Init(normal(Enemy.Location - Location));
        MyMesh.SetMaterial(0,AttackingMat);
        SetTimer(1,false,'EndAttack');
    }
}

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
    {
        local TestEnemy TE;
        Health -= DamageAmount;
        if(Health <= 0 && EventInstigator != none && EventInstigator.PlayerReplicationInfo != none)
        {
            WorldInfo.Game.ScoreObjective(EventInstigator.PlayerReplicationInfo, 1);
            foreach DynamicActors(class'TestEnemy',TE)
            {
                if(TE != self) TE.RunAway();
            }
            Destroy();
        }
        else if((Health / MaxHealth) <= 0.2)
        {
            GoToState('RageMode');
        }
    }
    
defaultproperties
{
    MovementSpeed=128.0
    Begin Object Name=PickupMesh
        Scale3d=(X=1.0,Y=1.0,Z=2.0)
    End Object
    Begin Object Name=collisionCylinder
        CollisionRadius=128.0
        CollisionHeight=256.0
    End Object
    MaxHealth = 500
    SeekingMat=Material'EditorMaterials.WidgetMaterial_Y'
    AttackingMat=Material'EditorMaterials.WidgetMaterial_Z'
    FleeingMat=Material'EditorMaterials.WidgetMaterial_X'
}