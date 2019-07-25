/**
 * NoraUi is licensed under the license GNU AFFERO GENERAL PUBLIC LICENSE
 * 
 * @author Nicolas HALLOUIN
 * @author Stéphane GRILLON
 */
package com.github.noraui.application.page.bakery;

import static com.github.noraui.utils.Context.BAKERY_KEY;
import static com.github.noraui.utils.Context.BAKERY_ADMIN;

import org.openqa.selenium.support.ui.ExpectedConditions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.noraui.application.page.Page;
import com.github.noraui.exception.Callbacks;
import com.github.noraui.utils.Context;
import com.github.noraui.utils.Utilities;

public class AdminPage extends Page {

    /**
     * Specific LOGGER
     */
    protected static final Logger LOGGER = LoggerFactory.getLogger(AdminPage.class);

    public final PageElement titleMessage = new PageElement("-title_message");
    
    public final PageElement accountMenu = new PageElement("-accountMenu", "Account menu");
    public final PageElement signOutMenu = new PageElement("-signout_menu");

    public AdminPage() {
        super();
        this.application = BAKERY_KEY;
        this.pageKey = BAKERY_ADMIN;
        this.callBack = Context.getCallBack(Callbacks.CLOSE_WINDOW_AND_SWITCH_TO_BAKERY_HOME);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean checkPage(Object... elements) {
        try {
            Context.waitUntil(ExpectedConditions.visibilityOfElementLocated(Utilities.getLocator(titleMessage)));
            return true;
        } catch (Exception e) {
            LOGGER.error("signIn message not found", e);
            return false;
        }
    }

}
