class AwesomeAIController extends AIController;

var Actor Target;
var() Vector TempDest;
var bool bAttacking;
var float AttackDistance, WeaponDamage;

event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    Pawn.SetMovementPhysics();
}

auto state Idle
{
    /* This would make the Enemy not move until it sees the player
    event SeePlayer (Pawn Seen)
    {
        super.SeePlayer(Seen);
        Target = Seen;
        
        GoToState('Follow');
    }
    */
    
    function Tick(float DeltaTime)
    {
        if(Target == none) GetEnemy();
        if(Target != none)
        {
            GotoState('Follow');
        }
    }
    
    Begin:
}

state Follow
{
    function BeginState(name PreviousState)
    {
        //`log("********************************Following!");
    }
    
    ignores SeePlayer;
    function bool FindNavMeshPath()
    {
        //Clear Cache and constraints
        NavigationHandle.PathConstraintList = none;
        NavigationHandle.PathGoalList = none;
        
        //Create Constraints
        class'NavMeshPath_Toward'.static.TowardGoal(NavigationHandle,target);
        class'NavMeshGoal_At'.static.AtActor(NavigationHandle, target,32);
        
        //Find Path
        return NavigationHandle.FindPath();
    }
    
    function EndAttack()
    {
        bAttacking = false;
    }
    
    Begin:
    
    if(NavigationHandle.ActorReachable(target))
    {
    
        if(VSize(Pawn.Location - target.location) <= AttackDistance)
        {
            GoToState('Attacking');
        }
            FlushPersistentDebugLines();
            //Direct move
            MoveToward(target,target);
    }
    else if(FindNavMeshPath())
    {
        NavigationHandle.SetFinalDestination(target.Location);
        FlushPersistentDebugLines();
        NavigationHandle.DrawPathCache(,true);
        
        //move to the first node on the path
        if(NavigationHandle.GetNextMoveLocation(TempDest,Pawn.GetCollisionRadius()))
        {
            //Show Debug Info
            DrawDebugLine(Pawn.Location,TempDest,255,0,0,true);
            DrawDebugSphere(TempDest,16,20,255,0,0,true);
            
            //Actually Move
            MoveTo(TempDest,target);
        }
    }
    else
    {
        //We can't follow so GTFO
        GotoState('Idle');
    }
    
    goto 'Begin';
}

state Attacking
{
    function BeginState(name PreviousState)
    {
    }
    
    function EndAttack()
    {
        bAttacking = false;
    }
    
    ignores seePlayer;
    
    Begin:
        //`log("********************************Attacking!");
        Sleep(0.25);
        Attack();
    
    if(VSize(Pawn.Location - target.location) > AttackDistance || target == none)
    {
        //`log("*********************************He's Getting Away!");
        GoToState('Idle');
    }
    
    goto 'Begin';
}
    
function Attack()
    {
    }

function GetEnemy()
    {
        local AwesomePlayerController PC;
        foreach LocalPlayerControllers(class'AwesomePlayercontroller', PC)
        {
            if(PC.Pawn != none) Target = PC.Pawn;
        }
    }

defaultproperties
{
    bAttacking = false
    AttackDistance = 400
    WeaponDamage = 20
}