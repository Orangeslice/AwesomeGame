class TestEnemy extends AwesomeActor
    abstract;
    
    var float BumpDamage, AttackDistance;
    var Pawn Enemy;
    var float MovementSpeed;
    var Material SeekingMat, AttackingMat, FleeingMat;
    var StaticMeshComponent MyMesh;
    var bool bAttacking;
    
    auto state Seeking
    {
        function BeginState(Name PreivousStateName)
        {
            SetMaterial(SeekingMat);
        }
        
    function Tick(float Deltatime)
    {
        local vector NewLocation;
        if(Enemy == none) GetEnemy();
        if(Enemy != none)
        {
            NewLocation = Location;
            if(bAttacking) return;
            NewLocation += normal(Enemy.Location - Location) * MovementSpeed * DeltaTime;
            SetLocation(NewLocation);
            if(VSize(NewLocation - Enemy.Location) < AttackDistance) GoToState('Attacking');
        }
    }
    }
    
    state Attacking
    {
        function BeginState(Name PreivousStateName)
        {
            SetMaterial(AttackingMat);
        }
        
        function Tick(float DeltaTime)
        {
            local vector NewLocation;
            bAttacking = true;
            if(Enemy == none) GetEnemy();
            if(Enemy != none) Enemy.Bump(self, CollisionComponent, vect(0,0,0));
            if(VSize(NewLocation - Enemy.Location) > AttackDistance) GoToState('Seeking');
        }
        
        function EndState(name NextStateName)
        {
            SetTimer(1,false,'EndAttack');
        }
    }

    state Fleeing
    {
        function BeginState(Name PreivousStateName)
        {
            SetMaterial(FleeingMat);
        }
        
        function Tick(float DeltaTime)
        {
        local vector NewLocation;
        if(Enemy == none) GetEnemy();
        if(Enemy != none)
        {
            NewLocation = Location;
            NewLocation -= normal(Enemy.Location - Location) * MovementSpeed * DeltaTime;
            SetLocation(NewLocation);
        }
        }
    }
    
    function SetMaterial (material Material)
    {
        MyMesh.SetMaterial(0,Material);
    }
    
    function EndAttack()
    {
        bAttacking = false;
        SetMaterial(SeekingMat);
    }

    function GetEnemy()
    {
        local AwesomePlayerController PC;
        foreach LocalPlayerControllers(class'AwesomePlayercontroller', PC)
        {
            if(PC.Pawn != none) Enemy = PC.Pawn;
        }
    }

    function RunAway()
    {
    }

defaultproperties
{
    bBlockActors=true
    bCollideActors=true
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=true
    End Object
    Components.Add(MyLightEnvironment)
    Begin Object Class=StaticMeshComponent Name=PickupMesh
        StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
        Materials(0)=Material'EditorMaterials.WidgetMaterial_X'
        LightEnvironment=MyLightEnvironment
        Scale3D=(X=0.25,Y=0.25,Z=0.5)
    End Object
    /*
    Begin Object Class=SkeletalMeshComponent Name=PickupMesh
        SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
    End Object
    */
    Components.Add(PickupMesh)
    MyMesh=PickupMesh
    Begin Object Class=CylinderComponent Name=CollisionCylinder
        CollisionRadius=32.0
        CollisionHeight=64.0
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        BlockActors=true
        CollideActors=true
    End Object
    CollisionComponent=CollisionCylinder
    Components.Add(CollisionCylinder)
    BumpDamage=5.0
    MovementSpeed=256.0
    AttackDistance = 96.0
    SeekingMat=Material'EditorMaterials.WidgetMaterial_X'
    AttackingMat=Material'EditorMaterials.WidgetMaterial_Z'
    FleeingMat=Material'EditorMaterials.WidgetMaterial_Y'
    bAttacking=false
}