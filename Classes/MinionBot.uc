class MinionBot extends AwesomeBot
    placeable;

defaultproperties
{
    ControllerClass=class'AwesomeGame.MinionAI'
    GroundSpeed = 200
    
    Begin Object Class=SkeletalMeshComponent Name=SandboxPawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        HiddenGame=FALSE
        HiddenEditor=FALSE
        BlockRigidBody=TRUE
        bHasPhysicsAssetInstance=true
        Scale3D=(X=1,Y=1,Z=1)
    End Object
 
    Mesh=SandboxPawnSkeletalMesh
 
    Components.Add(SandboxPawnSkeletalMesh)
    ScoreValue = 50
}