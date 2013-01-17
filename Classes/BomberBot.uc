class BomberBot extends AwesomeBot;

simulated Event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    super.TakeDamage(DamageAmount, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    HurtRadius(300, 300, class'AwesomeGame.BomberDamage', 10, location);
    Destroy();
}

defaultproperties
{
    ControllerClass=class'AwesomeGame.BomberAI'
    GroundSpeed = 150
    
    Begin Object Class=SkeletalMeshComponent Name=SandboxPawnSkeletalMesh
        SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
        AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
        AnimTreeTemplate=AnimTree'CH_AnimHuman_Tree.AT_CH_Human'
        bCacheAnimSequenceNodes=false
        AlwaysLoadOnClient=true
        AlwaysLoadOnServer=true
        CastShadow=true
        BlockRigidBody=true
        bUpdateSkelWhenNotRendered=false
        bIgnoreControllersWhenNotRendered=true
        bUpdateKinematicBonesFromAnimation=true
        bCastDynamicShadow=true
        RBChannel=RBCC_Untitled3
        RBCollideWithChannels=(Untitled3=true)
        //LightEnvironment=MyLightEnvironment
        bOverrideAttachmentOwnerVisibility=true
        bAcceptsDynamicDecals=false
        bHasPhysicsAssetInstance=true
        TickGroup=TG_PreAsyncWork
        MinDistFactorForKinematicUpdate=0.2f
        bChartDistanceFactor=true
        RBDominanceGroup=20
        Scale=0.5
        bAllowAmbientOcclusion=false
        bUseOnePassLightingOnTranslucency=true
        bPerBoneMotionBlur=true
        //HiddenGame=FALSE
        //HiddenEditor=FALSE
        //BlockRigidBody=TRUE
        //bHasPhysicsAssetInstance=true
        //Scale3D=(X=0.5,Y=0.5,Z=0.5)
    End Object
    
    
 
    Mesh=SandboxPawnSkeletalMesh
 
    Components.Add(SandboxPawnSkeletalMesh)
}