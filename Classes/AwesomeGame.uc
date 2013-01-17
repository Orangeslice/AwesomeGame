class AwesomeGame extends UTDeathmatch;

var array<AwesomeEnemySpawner> EnemySpawners;
var float MinSpawnerDistance, MaxSpawnerDistance;
var bool bSpawnBoss;
var int Score,TotalEnemies,EnemiesLeft;

function AddScore(int ScoreAdded)
{
    //Add to the Game Score
    Score += ScoreAdded;
}

function EnemyKilled()
{
    local int i;
    if(bSpawnBoss) return;
    EnemiesLeft--;
    //super.ScoreObjective(Scorer, Score);
    if(EnemiesLeft <= 0)
    {
        for(i=0; i<EnemySpawners.length; i++) EnemySpawners[i].MakeEnemyRunAway();
        ClearTimer('ActivateSpawners');
        ActivateSpawners();
    }
}

simulated function PostBeginPlay()
{
    local AwesomeEnemySpawner ES;
    super.PostBeginPlay();
    GoalScore = EnemiesLeft;
    foreach DynamicActors(class'AwesomeEnemySpawner', ES) EnemySpawners[EnemySpawners.length] = ES;
    ActivateSpawners();
}

function ActivateSpawners()
{
    local array<AwesomeEnemySpawner> InRangeSpawners;
    local int i, EnemyCount, EnemyClass;
    local AwesomePlayerController PC;
    local AwesomeBot AB;
    foreach LocalPlayerControllers(class'AwesomePlayerController',PC)
    break;
    
    
    
    if(PC.Pawn == none)
    {
        SetTimer(1.0,false,'ActivateSpawners');
        return;
    }
    
    for(i=0; i<EnemySpawners.length; i++)
    {
        if(VSize(PC.Pawn.Location - EnemySpawners[i].Location) > MinSpawnerDistance)
        {
            if(EnemySpawners[i].CanSpawnEnemy()) InRangeSpawners[InRangeSpawners.length] = EnemySpawners[i];
        }
    }    
    if(InRangeSpawners.length == 0)
    {
        SetTimer(1.0, false, 'ActivateSpawners');
        return;
    }
    
    if(bSpawnBoss) InRangeSpawners[Rand(InRangeSpawners.length)].SpawnBoss();
    else
    {
        //Count how many enemies we have already. If there's too many, go back
        EnemyCount = 0 ;
        foreach DynamicActors(class'AwesomeBot', AB) EnemyCount += 1;
        `log("**************************ENEMYCOUNT: "@EnemyCount);
        if(EnemyCount > TotalEnemies) 
        {
            SetTimer(1.0, false, 'ActivateSpawners');
        }
        else
        {
            EnemyClass = Rand(10);
            if(EnemyClass < 5) InRangeSpawners[Rand(InRangeSpawners.length)].SpawnMinion();
            if(EnemyClass >= 5 && EnemyClass < 8) InRangeSpawners[Rand(InRangeSpawners.length)].SpawnHeavy();
            if(EnemyClass >= 8) InRangeSpawners[Rand(InRangeSpawners.length)].SpawnBomber();
            SetTimer(1.0, false, 'ActivateSpawners');
        }
    }
}

defaultproperties
{
    bScoreDeaths=false
    PlayerControllerClass=class'AwesomeGame.AwesomePlayerController'
    HUDType=class'AwesomeGame.AwesomeHUD'
    bUseClassicHUD=true
    DefaultInventory(0)=AwesomeGame.AwesomeWeapon_LinkGun
    DefaultPawnClass=class'AwesomeGame.AwesomePawn'
    MinSpawnerDistance = 1000.0
    MaxSpawnerDistance = 3000.0
    Score = 0
    TotalEnemies = 8
    EnemiesLeft = 200
}