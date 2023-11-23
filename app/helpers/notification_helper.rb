module NotificationHelper

  def status_text_buyer(booking)
    case booking.status.to_sym
    when :created
      "Offre transmise au vendeur"
    when :accepted
      "Offre acceptée par le vendeur ! Allez récupérer votre vin !"
    when :rejected
      "Désolé, votre offre a été rejetée."
    when :delivered
      "Vous avez bien récupéré cette commande ! Bonne dégustation"
    else
      "Statut inconnu. Veuillez contacter le support pour obtenir de l'aide."
    end
  end

  def status_text_seller(booking)
    case booking.status.to_sym
    when :created
      "
      <div class='d-flex justify-content-between m-0'>
        <p><strong>#{booking.wine.name}</strong> : Vous avez reçu une offre de #{booking.user.username} - #{booking.wine.price} € </p>
        <div>
          #{link_to 'Valider', validate_booking_path(booking), method: :patch, class: 'btn btn-primary btn-sm'}
          #{link_to 'Refuser', '#', class: 'btn btn-danger btn-sm'}
        </div>
      </div>
      "
    when :accepted
      "
        <p class='m-0'><strong>#{booking.wine.name}</strong> : Vous avez accepté l'offre de #{booking.user.username} - #{booking.wine.price} €.</p>
        <p><strong>Prochaines étape: </strong> Convenez d'un rendez-vous en l'appelant au  : #{booking.user.phone_number}</p>
      "
    when :rejected
      "Vous avez refusé l'offre"
    when :delivered
      "Vendu avec succès"
    else
      "Statut inconnu. Veuillez contacter le support pour obtenir de l'aide."
    end
  end


end
