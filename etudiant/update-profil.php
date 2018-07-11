<?php
require_once '../lib/functions.php';
require_once '../model/database.php';

$user = currentUser();
$etudiant = getEtudiant($user["id"]);

if (!isset($etudiant["id"])) {
    header("Location: ../index.php");
}

$niveau_etudes = getAllEntity("niveau_etude");

getHeader("Profil");
?>
<section class="container-page">
<form action="update.php" method="post" class="form-signin inscription">
    <h1 class="h3 mb-3 font-weight-normal">Modifier son profil</h1>
    
    <label>Nom</label>
    <input type="nom" name="nom" id="nom" class="form-control" placeholder="<?php echo $etudiant["nom"]; ?>" required autofocus>
    <br>
    <label>Prénom</label>
    <input type="prenom" name="prenom" id="prenom" class="form-control" placeholder="<?php echo $etudiant["prenom"]; ?>" required autofocus>
    <br>
    <label>Date de Naissance</label>
    <input type="datenaissance" name="datenaissance" id="datenaissance" class="form-control" placeholder="<?php echo $etudiant["date_naissance_format"]; ?>" required autofocus>
    <br>
    <label>Email</label>
    <input type="email" name="email" id="email" class="form-control" placeholder="<?php echo $etudiant["mail"]; ?>" required autofocus>
    <br>
    <label>Téléphone</label>
    <input type="telephone" name="telephone" id="telephone" class="form-control" placeholder="<?php echo $etudiant["telephone"]; ?>" required autofocus>
    <br>
    <label>Niveau études</label>
    <select class="select2" name="niveau_etude">
        <?php foreach($niveau_etudes as $niveau_etude) : ?>
        <option value="<?php echo $niveau_etude["id"]; ?>" <?php echo ($niveau_etude["id"] == $etudiant["niveau_etude_id"]) ? "selected" : ""; ?>>
            <?php echo $niveau_etude["label"]; ?>
        </option>
        <?php endforeach; ?>
    </select>
    <br>
    <label>Spécialités</label>
    <input type="specialite" name="specialite" id="specialite" class="form-control" placeholder="" >
    <br>
    <label>CV</label>
    <input type="cv" name="cv" id="cv" class="form-control" placeholder="<?php echo $etudiant["cv"]; ?>" >
    <br>
    <label>Lettre de motivation</label>
    <input type="lettremotivation" name="lettremotivation" id="specialite" class="form-control" placeholder="<?php echo $etudiant["lm"]; ?>">
    
    <button class="btn btn-lg btn-primary btn-block" type="submit">Valider</button>
</form>
</section>

<?php getFooter(); ?>