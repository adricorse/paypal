{*
 * 2007-2023 PayPal
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 *  versions in the future. If you wish to customize PrestaShop for your
 *  needs please refer to http://www.prestashop.com for more information.
 *
 *  @author 2007-2023 PayPal
 *  @author 202 ecommerce <tech@202-ecommerce.com>
 *  @license http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *  @copyright PayPal
 *
 *}
{extends file="module:paypal/views/templates/admin/_partials/forms/form.tpl"}
{assign var="isModal" value=$isModal|default:false}

{block name='form_content'}
  {foreach from=$form.fields key=fieldKey item=field}
    {if $fieldKey == 'account_form'}
      {assign var="isShowCredentials" value=in_array($field.set.country_iso, ['MX', 'BR', 'JP', 'IN'])}

      <input type="hidden" name="is_configured_live" value="{$field.set.is_configured_live}">
      <input type="hidden" name="is_configured_sandbox" value="{$field.set.is_configured_sandbox}">

      {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
        'type' => 'select',
        'name' => 'mode',
        'value' => $field.set.mode|default:'',
        'options' => [
          [
            'value' => 'LIVE',
            'title' => "{l s='Production' mod='paypal'}"
          ],
          [
            'value' => 'SANDBOX',
            'title' => "{l s='Sandbox' mod='paypal'}"
          ]
        ],
        'label' => "{l s='Mode' mod='paypal'}",
        'variant' => 'primary'
      ]}

      <div credential-section>
        <div live-section style="display: none">
            {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
            'type' => 'text',
            'name' => 'paypal_clientid_live',
            'label' => "{l s='Client\’s ID' mod='paypal'}",
            'variant' => 'primary',
            'value' => $field.set.paypal_clientid_live|default:''
            ]}
            {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
            'type' => 'text',
            'name' => 'paypal_secret_live',
            'label' => "{l s='Client\’s secret' mod='paypal'}",
            'variant' => 'primary',
            'value' => $field.set.paypal_secret_live|default:''
            ]}
            {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
            'type' => 'text',
            'name' => 'merchant_id_live',
            'value' => $field.set.merchant_id_live|default:'',
            'label' => "{l s='Merchant ID' mod='paypal'}",
            'variant' => 'primary'
            ]}
        </div>

        <div sandbox-section style="display: none">
            {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
            'type' => 'text',
            'name' => 'paypal_clientid_sandbox',
            'label' => "{l s='Client\’s ID' mod='paypal'}",
            'variant' => 'primary',
            'value' => $field.set.paypal_clientid_sandbox|default:''
            ]}
            {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
            'type' => 'text',
            'name' => 'paypal_secret_sandbox',
            'label' => "{l s='Client\’s secret' mod='paypal'}",
            'variant' => 'primary',
            'value' => $field.set.paypal_secret_sandbox|default:''
            ]}
            {include file="module:paypal/views/templates/admin/_partials/form-fields.tpl" field=[
            'type' => 'text',
            'name' => 'merchant_id_sandbox',
            'value' => $field.set.merchant_id_sandbox|default:'',
            'label' => "{l s='Merchant ID' mod='paypal'}",
            'variant' => 'primary'
            ]}
        </div>
      </div>


        <div onboarding-button-section>

          <div live-section style="display: none">

            <div class="form-group row">
              <div class="offset-3 {[
              'col-7' => !$isModal,
              'col-9' => $isModal
              ]|classnames}">
                <a
                  href="{$field.set.urlOnboarding_live}"
                  class="btn btn-secondary btn-block"
                  target="_blank"
                  data-paypal-button
                  data-paypal-onboard-complete="onboardCallback"
                >
              <span class="icon mr-2">
                <i class="material-icons-outlined">account_circle</i>
              </span>
                  <span>
                {l s='Connect or create your PayPal account' mod='paypal'}
              </span>
                </a>
              </div>
            </div>

          </div>

          <div sandbox-section style="display: none">

            <div class="form-group row">
              <div class="offset-3 {[
              'col-7' => !$isModal,
              'col-9' => $isModal
              ]|classnames}">
                <a
                  href="{$field.set.urlOnboarding_sandbox}"
                  class="btn btn-secondary btn-block"
                  target="_blank"
                  data-paypal-button
                  data-paypal-onboard-complete="onboardCallback"
                >
              <span class="icon mr-2">
                <i class="material-icons-outlined">account_circle</i>
              </span>
                  <span>
                {l s='Connect or create your PayPal account' mod='paypal'}
              </span>
                </a>
              </div>
            </div>

          </div>

          <div logout-section style="display: none">

            <div class="form-group row">
              <div class="offset-3 {[
              'col-7' => !$isModal,
              'col-9' => $isModal
              ]|classnames}">
              <span class="btn btn-secondary btn-block" logout-button>
              <span class="icon mr-2">
                <i class="material-icons-outlined">account_circle</i>
              </span>
                <span>
                {l s='Logout' mod='paypal'}
              </span>
              </span>
              </div>
            </div>

          </div>

        </div>

    {/if}
  {/foreach}

  <script>
    function onboardCallback(authCode, sharedId) {
      document.dispatchEvent(
        (new CustomEvent(
          'generateCredentials',
          {
            bubbles: true,
            detail: {
              authCode: authCode,
              sharedId: sharedId,
            }
          }
        ))
      );
    }

    window.addEventListener('load', function() {
      var script = document.createElement('script');
      script.src = 'https://www.paypal.com/webapps/merchantboarding/js/lib/lightbox/partner.js';
      document.body.appendChild(script);

      var event = new CustomEvent(
        '{if $isShowCredentials}updateCredentials{else}updateButtonSection{/if}',
        {
          bubbles: true
        }
      );
      var mode = document.querySelector('#pp_account_form [name="mode"]');

      mode.addEventListener('change', function() {
        document.dispatchEvent(event);
      });
      document.dispatchEvent(event);

    });



  </script>

{/block}

{block name='form_footer_buttons'}
  {if $isModal}
    <div>
      <div merchant-label-sandbox class="alert alert-warning mt-0" style="display: none">
          {l s='You are connected with the accound:' mod='paypal'}
        <b merchant-id></b>
      </div>
      <div merchant-label-live class="alert alert-warning mt-0" style="display: none">
          {l s='You are connected with the accound:' mod='paypal'}
        <b merchant-id></b>
      </div>
    </div>
  {/if}
  <button save-form class="btn btn-secondary ml-auto" name={$form.submit.name}>{$form.submit.title}</button>
{/block}
