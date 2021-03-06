<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Backup.ascx.cs" Inherits="ASC.Web.Studio.UserControls.Management.Backup" %>
<%@ Import Namespace="ASC.Web.Studio.Core" %>
<%@ Import Namespace="ASC.Web.Studio.Utility" %>
<%@ Import Namespace="Resources" %>

<div id="backup-manager-view">
    <div id="backupBox" class="backupBox clearFix <%= EnableBackup ? "" : "disable" %>">
        <div class="settings-block">
            <div class="header-base"><%= Resource.DataBackup %></div>
            <div class="backupBoxDscr"><%= Resource.BackupText %></div>
            
            <div class="backupBoxHeader"><%= Resource.BackupStorage %>:</div>
            <ul id="backupStoragesBox" class="backupStoragesBox clearFix">
                <li>
                    <input id="backupTempStorage" type="radio" name="backupStorageSelector" value="4" checked="checked"/>
                    <label for="backupTempStorage"><%= Resource.BackupTempTeamlab %></label>
                </li>
                <li>
                    <input id="backupTeamlabStorage" type="radio" name="backupStorageSelector" value="0"/>
                    <label for="backupTeamlabStorage"><%= Resource.BackupDocsTeamlab %></label>
                </li>
                <li id="backupThirdPartyStorageSelectorBox" class="thirdPartyStorageSelectorBox disabled" title="<%= string.Format(Resource.BackupNotAvailableThirdServices, "\n").HtmlEncode() %>">
                    <input id="backupThirdPartyStorage" type="radio" name="backupStorageSelector" value="1" disabled/>
                    <label for="backupThirdPartyStorage">
                        <span class="thirdPartyStorageSelectorHelper HelpCenterSwitcher expl" data-helpboxselector="backupThirdPartyStorageSelectorHelpBox">
                        </span>
                        DropBox, Box.com, OneDrive, Google Drive...
                    </label>
                    <div id="backupThirdPartyStorageSelectorHelpBox" class="popup_helper">
                        <p><%= Resource.BackupThirdStorageDisable %></p>
                        <div class="cornerHelpBlock pos_top"></div>
                    </div>
                </li>
                <li>
                    <input id="backupAmazonStorage" type="radio" name="backupStorageSelector" value="2"/>
                    <label for="backupAmazonStorage"><%= Resource.BackupCloud %> Amazon</label>
                </li>
            </ul>
            
            <div class="teamlabStorageFolderSelectorBox">
                <input id="backupTeamlabStorageFolderSelector" type="text" class="teamlabStorageFolderSelector textEdit" readonly="readonly"/>
                <div id="backupTeamlabStorageFolderSelectorBtn" class="button gray middle"><%= Resource.Choose %></div>
            </div>
            <asp:PlaceHolder runat="server" ID="FolderSelectorHolder"></asp:PlaceHolder>
            
            <div id="backupAmazonStorageSettingsBox" class="amazonStorageSettingsBox display-none">
                <input type="text" class="amazonStorageSettingsParam accessKeyId textEdit" placeholder="Access Key Id"/>
                <input type="text" class="amazonStorageSettingsParam secretAccessKey textEdit" placeholder="Secret Access Key" />
                <input type="text" class="amazonStorageSettingsParam bucket textEdit" placeholder="Bucket Name" />
                <select class="amazonStorageSettingsParam region textEdit">
                    <option value=""><%= Resource.ChooseRegion %></option>
                    <% foreach (var region in Regions)
                       { %>
                        <option value="<%= region.SystemName %>"><%= region.DisplayName %></option>
                    <% } %>
                </select>
            </div>

            <div class="clearFix">
                <input id="backupWithMailCheck" type="checkbox" />
                <label for="backupWithMailCheck"><%= Resource.BackupMakeWithMail %></label>
            </div>

            <% if (AvailableStatus != BackupAvailableSize.Available)
               { %>
            <div id="spaceExceedMessage" class="toast-popup-container" data-status="<%= AvailableStatus %>">
                <div class="toast toast-error">
                    <div class="toast-message">
                        <%= string.Format(UserControlsCommonResource.BackupSpaceExceed,
                                          FileSizeComment.FilesSizeToString(AvailableZipSize),
                                          "<a class=\"link underline\" href=\"" + CommonLinkUtility.GetAdministration(ManagementType.Statistic) + "\">",
                                          "</a>") %>
                    </div>
                </div>
            </div>
            <% } %>

            <div class="middle-button-container">
                <a id="startBackupBtn" class="button blue middle"><%= Resource.BackupMakeCopyBtn %></a>
            </div>

            <div id="backupProgressBox">
                <div class="asc-progress-wrapper">
                    <div id="backupProgressValue" class="asc-progress-value"></div>
                </div>
                <div class="text-medium-describe">
                    <%= Resource.CreatingBackup %>
                    <span id="backupProgressText"></span>
                </div>
            </div>

            <div id="backupResultLinkBox">
                <p><%= Resource.BackupReadyText %></p>
                <a id="backupResultLink" target="_blank" class="link gray dotline"><%= Resource.BackupDownloadByLink %></a>
            </div>
        </div>

        <div class="settings-help-block">
            <% if (!EnableBackup)
               { %>
                <p><%= Resource.ErrorNotAllowedOption %></p>
                <a href="<%= TenantExtra.GetTariffPageLink() %>" target="_blank"><%= Resource.ViewTariffPlans %></a>
            <% }
               else
               { %>
                <p><%= string.Format(Resource.DataBackupHelp, "<b>", "</b>", "<br />") %></p>
                <% if (!string.IsNullOrEmpty(CommonLinkUtility.GetHelpLink()))
                   { %>
                    <a href="<%= CommonLinkUtility.GetHelpLink() + "gettingstarted/configuration.aspx#CreatingBackup_block" %>" target="_blank">
                        <%= Resource.LearnMore %>
                    </a>
                <% } %>
            <% } %>
        </div>
    </div>

    <div id="autoBackupSettingsBox" class="backupBox clearFix <%= EnableBackup ? "" : "disable" %>">
        <div class="settings-block">
            <div class="header-base"><%= Resource.AutoDataBackup %></div>
            <div class="backupBoxDscr"><%= Resource.AutoBackupText %></div>
        
            <ul id="autoBackupSwitchBox" class="clearFix">
                <li>
                    <input id="autoBackupOff" type="radio" name="autoBackupSwitch" value="0"/>
                    <label for="autoBackupOff"><%= Resource.AutoBackupOff %></label>
                </li>
                <li>
                    <input id="autoBackupOn" type="radio" name="autoBackupSwitch" value="1"/>
                    <label for="autoBackupOn"><%= Resource.AutoBackupOn %></label>
                </li>
            </ul>
            
            <div id="autoBackuSettingsBlock">
                <ul id="autoBackupSettingsStoragesBox" class="backupStoragesBox clearFix">
                    <li>
                        <input id="autoBackupSettingsTeamlabStorage" type="radio" name="autoBackupSettingsStorageSelector" value="0"/>
                        <label for="autoBackupSettingsTeamlabStorage"><%= Resource.BackupDocsTeamlab %></label>
                    </li>
                    <li class="thirdPartyStorageSelectorBox disabled" title="<%= string.Format(Resource.BackupNotAvailableThirdServices, "\n").HtmlEncode() %>" >
                        <input disabled id="autoBackupSettingsThirdPartyStorage" type="radio" name="autoBackupSettingsStorageSelector" value="1"/>
                        <label for="autoBackupSettingsThirdPartyStorage">
                            <span class="thirdPartyStorageSelectorHelper HelpCenterSwitcher expl" data-helpboxselector="autoBackupSettingsThirdPartyStorageSelectorHelpBox">
                            </span>
                            DropBox, Box.com, OneDrive, Google Drive...
                        </label>
                        <div id="autoBackupSettingsThirdPartyStorageSelectorHelpBox" class="popup_helper">
                            <p><%= Resource.BackupThirdStorageDisable %></p>
                            <div class="cornerHelpBlock pos_top"></div>
                        </div>
                    </li>
                    <li>
                        <input id="autoBackupSettingsAmazonStorage" type="radio" name="autoBackupSettingsStorageSelector" value="2"/>
                        <label for="autoBackupSettingsAmazonStorage"><%= Resource.BackupCloud %> Amazon</label>
                    </li>
                </ul>

                <div id="autoBackupSettingsTeamlabStorageFolderSelectorBox" class="teamlabStorageFolderSelectorBox">
                    <input id="autoBackupSettingsTeamlabStorageFolderSelector" type="text" class="teamlabStorageFolderSelector textEdit" readonly="readonly"/>
                    <div id="autoBackupSettingsTeamlabStorageFolderSelectorBtn" class="button gray middle"><%= Resource.Choose %></div>
                </div>

                <div id="autoBackupSettingsAmazonStorageSettingsBox" class="amazonStorageSettingsBox display-none">
                    <input type="text" class="amazonStorageSettingsParam accessKeyId textEdit" placeholder="Access Key Id"/>
                    <input type="text" class="amazonStorageSettingsParam secretAccessKey textEdit" placeholder="Secret Access Key" />
                    <input type="text" class="amazonStorageSettingsParam bucket textEdit" placeholder="Bucket Name" />
                    <select class="amazonStorageSettingsParam region textEdit">
                        <option value=""><%= Resource.ChooseRegion %></option>
                        <% foreach (var region in Regions)
                           { %>
                            <option value="<%= region.SystemName %>"><%= region.DisplayName %></option>
                        <% } %>
                    </select>
                </div>
            
                <div class="clearFix">
                    <input id="autoBackupSettingsWithMailCheck" type="checkbox" />
                    <label for="autoBackupSettingsWithMailCheck"><%= Resource.BackupMakeWithMail %></label>
                </div>
        
                <div class="backup-settings_auto-params">
                    <asp:PlaceHolder runat="server" ID="BackupTimePeriod"></asp:PlaceHolder>
                    <div class="backup-settings_title"><%= Resource.BackupCopyCount %>:</div>
                    <select id="maxStoredCopiesCount"></select>
                </div>
            </div>
        
            <div class="middle-button-container">
                <a id="saveSettingsBtn" class="button gray middle"><%= Resource.SaveButton %></a>
            </div>
        </div>
    
        <div class="settings-help-block">
            <% if (!EnableBackup)
               { %>
                <p><%= Resource.ErrorNotAllowedOption %></p>
                <a href="<%= TenantExtra.GetTariffPageLink() %>" target="_blank"><%= Resource.ViewTariffPlans %></a>
            <% }
               else
               { %>
                <p><%= string.Format(Resource.AutoDataBackupHelp, "<b>", "</b>", "<br />") %></p>
                <% if (!string.IsNullOrEmpty(CommonLinkUtility.GetHelpLink()))
                   { %>
                    <a href="<%= CommonLinkUtility.GetHelpLink() + "gettingstarted/configuration.aspx#CreatingBackup_block" %>" target="_blank">
                        <%= Resource.LearnMore %>
                    </a>
                <% } %>
            <% } %>
        </div>
    </div>
</div>

<asp:PlaceHolder runat="server" ID="RestoreHolder"></asp:PlaceHolder>