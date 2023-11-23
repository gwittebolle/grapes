module NotificationHelper

  def status_text_buyer(booking)
    case booking.status.to_sym
    when :created
      "Offre transmise au vendeur"
    when :accepted
      "<p class='m-0'><strong>Offre acceptée par le vendeur !</strong></p>
      <p class='m-0'><strong>Prochaines étape: </strong> Convenez d'un rendez-vous avec #{booking.wine.user.first_name} #{booking.wine.user.last_name}.</p>
      <p class='m-0'><strong>Contact :</strong> #{booking.wine.user.phone_number}</p></p>"
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
        <p>#{booking.created_at.strftime("%d-%m-%Y à %H:%M ")} - <strong>#{booking.wine.name}</strong> : Vous avez reçu une offre de #{booking.user.username} - #{booking.wine.price} € </p>
        <div>
          #{link_to 'Valider', validate_booking_path(booking), method: :patch, class: 'btn btn-info btn-sm'}
          #{link_to 'Refuser', reject_booking_path(booking), method: :patch, class: 'btn btn-danger btn-sm'}
        </div>
      </div>
      "
    when :accepted
      "
      <div class='d-flex justify-content-between m-0'>
        <div>
        <p class='m-0'>#{booking.updated_at.strftime("%d-%m-%Y")} - <strong>#{booking.wine.name}</strong> : Vous avez accepté l'offre de #{booking.user.username} - #{booking.wine.price} €.</p>
        <p class='m-0'><strong>Prochaines étape: </strong> Convenez d'un rendez-vous avec #{booking.user.first_name} #{booking.user.last_name}.</p>
        <p class='m-0'><strong>Contact :</strong> #{booking.user.phone_number}</p>
        </div>
        <div>
        #{link_to 'Confirmer la livraison de la commande', deliver_booking_path(booking), method: :patch, class: 'btn btn-info btn-sm'}
        #{link_to 'Annuler', reject_booking_path(booking), method: :patch, class: 'btn btn-danger btn-sm'}
        </div>
      </div>
      "
    when :delivered
      "#{booking.updated_at.strftime("%d-%m-%Y")} - #{booking.wine.name} - #{booking.user.first_name} #{booking.user.last_name} - #{booking.wine.price} €"
    when :rejected
      "#{booking.updated_at.strftime("%d-%m-%Y")} - #{booking.wine.name} - #{booking.user.first_name} #{booking.user.last_name} "
    else
      "Statut inconnu. Veuillez contacter le support pour obtenir de l'aide."
    end
  end


end
