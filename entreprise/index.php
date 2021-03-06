<?php
require_once '../lib/functions.php';
require_once '../model/database.php';

$user = currentUser();

$entreprise_co = getEntreprise($user["id"]);

if (!isset($entreprise_co["id"])) {
    header("Location: ../index.php");
}

getHeader("Espace entreprise");
?>

<section class="container-page">

<h1>Entreprise</h1>

<?php
$id = $_SESSION['id'];
$entreprise = getEntreprise($id);
$departements = getAllDepartementByEtudiant($id);
?>

<h3>Mes infos</h3>
<img class="image-avatar" src="<?php echo SITE_URL ; ?>uploads/<?php echo $entreprise['avatar']?>">
<a class="btn" href="<?php echo SITE_URL ; ?>entreprise/update-avatar.php">Modifier ou ajouter mon profil</a>


<h3><?php echo $entreprise['nom'] ;?></h3>
<p><?php echo $entreprise['mail']; ?></p>

<a class="btn mdp" href="../entreprise/list-etudiant.php">Trouver l'élu</a>


<a class="btn deconnection" href="../admin/logout.php">Se déco</a>

<a class="btn mdp" href="../mpd_form.php">Modifier son mot de passe</a>

</section>

<?php require_once '../layout/footer.php'; ?>
