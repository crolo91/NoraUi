package noraui.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import noraui.exception.TechnicalException;

public class Messages {

    /**
     * Success message
     */
    public static final String SUCCESS_MESSAGE = "Succès";
    public static final String SUCCESS_MESSAGE_BY_DEFAULT = "Initialisation à Succès par défaut";

    /**
     * Default error message
     */
    public static final String FAIL_MESSAGE_DEFAULT = "Échec : ";

    /**
     * Errors of Gherkin and Cucumber.
     */
    public static final String SCENARIO_ERROR_MESSAGE_DEFAULT = "[ERROR] Erreur dans le scénario Gherkin : ";
    public static final String SCENARIO_ERROR_MESSAGE_TYPE_NOT_IMPLEMENTED = SCENARIO_ERROR_MESSAGE_DEFAULT + "le type « %s » n'est pas implementé dans la méthode « %s ».";
    public static final String SCENARIO_ERROR_MESSAGE_ILLEGAL_TAB_FORMAT = SCENARIO_ERROR_MESSAGE_DEFAULT
            + "les arguments autorisés sont \"    Given\",  \"    Then\",  \"    When\",  \"    And\", \"    But\", \"    Alors\", \"    Et\", \"    Lorsqu\", \"    Mais\", \"    Quand\" et \"    Soit\".";

    /**
     * Functional fail messages.
     */
    public static final String FAIL_MESSAGE_UNKNOWN_CREDENTIALS = FAIL_MESSAGE_DEFAULT + "Impossible de s'authentifier avec les informations fournies.";
    public static final String FAIL_MESSAGE_LIST = FAIL_MESSAGE_DEFAULT + "Erreur sur la donnée liste.";
    public static final String FAIL_MESSAGE_TEXT = FAIL_MESSAGE_DEFAULT + "Erreur sur la donnée texte.";
    public static final String FAIL_MESSAGE_UNABLE_TO_FIND_ELEMENT = FAIL_MESSAGE_DEFAULT + "Élément non trouvé sur la page.";
    public static final String FAIL_MESSAGE_UNABLE_TO_OPEN_A_NEW_WINDOW = FAIL_MESSAGE_DEFAULT + "lors de l'ouverture d'une nouvelle fenêtre.";

    /**
     * Functional fail messages with parameters.
     */
    public static final String FAIL_MESSAGE_UNABLE_TO_OPEN_APPLICATION = FAIL_MESSAGE_DEFAULT + "Ouverture %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_OPEN_PAGE = FAIL_MESSAGE_DEFAULT + "Ouverture %s.";
    public static final String FAIL_MESSAGE_ERROR_ON_INPUT = FAIL_MESSAGE_DEFAULT + "Saisie « %s » dans %s.";
    public static final String FAIL_MESSAGE_ERROR_CLEAR_ON_INPUT = FAIL_MESSAGE_DEFAULT + "Suppression « %s » dans %s.";

    public static final String FAIL_MESSAGE_UNEXPECTED_DATE = FAIL_MESSAGE_TEXT + " La date fournie doit être %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_OPEN_ON_CLICK = FAIL_MESSAGE_DEFAULT + "Accès à l'action « %s » dans %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_PASS_OVER_ELEMENT = FAIL_MESSAGE_DEFAULT + "Impossible de passer au dessus de « %s » dans %s.";
    public static final String FAIL_MESSAGE_EMPTY_MANDATORY_FIELD = FAIL_MESSAGE_DEFAULT + "Absence « %s » dans %s.";
    public static final String FAIL_MESSAGE_WRONG_DATE_FORMAT = FAIL_MESSAGE_DEFAULT + "Le format de la date %s du champ « %s » n'est pas valide.";
    public static final String FAIL_MESSAGE_UNABLE_TO_SWITCH_WINDOW = FAIL_MESSAGE_DEFAULT + "Impossible de passer à la fenêtre « %s ».";
    public static final String FAIL_MESSAGE_UNABLE_TO_RETRIEVE_VALUE = FAIL_MESSAGE_DEFAULT + "Récupération de %s dans %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_SELECT_RADIO_BUTTON = FAIL_MESSAGE_DEFAULT + "Sélection %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_CLOSE_APP = FAIL_MESSAGE_DEFAULT + "Fermeture de l'application %s.";
    public static final String FAIL_MESSAGE_VALUE_NOT_AVAILABLE_IN_THE_LIST = FAIL_MESSAGE_DEFAULT + "Sélection de « %s » dans %s.";
    public static final String FAIL_MESSAGE_WRONG_PAGE = FAIL_MESSAGE_DEFAULT + "La page « %s » est indisponible dans %s.";
    public static final String FAIL_MESSAGE_EMPTY_DATA_DETAIL = "La donnée « %s » fournie ne peut pas être vide.";
    public static final String FAIL_MESSAGE_EMPTY_DATA = FAIL_MESSAGE_DEFAULT + FAIL_MESSAGE_EMPTY_DATA_DETAIL;
    public static final String FAIL_MESSAGE_WRONG_EXPECTED_VALUE = FAIL_MESSAGE_DEFAULT + "La valeur du champ « %s » n'est pas celle attendue (%s) dans %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_EVALUATE_XPATH = FAIL_MESSAGE_DEFAULT + "Impossible d'évaluer le xpath: « %s » dans %s.";
    public static final String FAIL_MESSAGE_UNABLE_TO_CHECK_ELEMENT = FAIL_MESSAGE_DEFAULT + "(Dé)Cochage %s dans %s.";
    public static final String FAIL_MESSAGE_EMPTY_FIELD = FAIL_MESSAGE_DEFAULT + "Champ « %s » non valorisé dans %s.";
    public static final String FAIL_MESSAGE_NOT_FOUND_ON_ALERT = FAIL_MESSAGE_DEFAULT + "Message « %s » non trouvé sur l'alerte.";
    public static final String FAIL_MESSAGE_ALERT_NOT_FOUND = FAIL_MESSAGE_DEFAULT + "Alerte non trouvée.";

    /**
     * Format given message with provided arguments
     *
     * @param templateMessage
     *            Message to display before formatting
     * @param args
     *            Arguments
     * @return a String containing the message well formatted.
     * @throws TechnicalException
     *             if data input is wrong.
     */
    public static String format(String templateMessage, Object... args) throws TechnicalException {
        if (null != templateMessage && countWildcardsOccurrences(templateMessage, "%s") == args.length) {
            try {
                return String.format(templateMessage, args);
            } catch (Exception e) {
                throw new TechnicalException("Technical problem in the code Messages.formatMessage(String templateMessage, String... args) in NoraUi.", e);
            }
        } else {
            throw new TechnicalException("Technical problem in the code Messages.formatMessage(String templateMessage, String... args) in NoraUi.");
        }
    }

    /**
     * Count the number of occurrences of a given wildcard.
     *
     * @param templateMessage
     *            Input string
     * @param occurrence
     *            String searched.
     * @return The number of occurrences.
     */
    private static int countWildcardsOccurrences(String templateMessage, String occurrence) {
        if (templateMessage != null && occurrence != null) {
            Pattern pattern = Pattern.compile(occurrence);
            Matcher matcher = pattern.matcher(templateMessage);
            int count = 0;
            while (matcher.find()) {
                count++;
            }
            return count;
        } else {
            return 0;
        }
    }

}