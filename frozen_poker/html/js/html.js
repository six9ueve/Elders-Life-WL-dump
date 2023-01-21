const HTMLCode = `<div class="main-shit" v-if="visible">
<div class="join-container" v-if="player.id == 0 && !joined && !editing">
    <button style="left: 44.5%;" class="mdc-button red-glow mdc-button--raised" v-on:click="closeUI">
        <div class="mdc-button__ripple"></div>
        <span class="mdc-button__label">X</span>
    </button>
    <button v-if="player.isOwner && table.players.length <= 0" style="margin-top: 2%; left: 42.5%;" class="mdc-button orange-glow mdc-button--raised" v-on:click="openEditUI(true)">
        <div class="mdc-button__ripple"></div>
        <i class="material-icons mdc-button__icon" aria-hidden="true">build</i>
        <span class="mdc-button__label">${Locale.editTable}</span>
    </button>
    <div class="poker-logo">
        <img src="img/logo.png" alt="" srcset="">
    </div>
    <div class="poker-welcome">
        <span id="welcome-text">${Locale.welcomeTo} {{ table.settings.name }}, <strong><span id="name">{{ player.name }}</span></strong>
        <p>${Locale.yourWallet}: <strong><span id="balance"><strong>\${{ wallet }}</strong></span>
            </strong>
        </p>
        <p>${Locale.smallBlind}: <strong><span id="balance"><strong>\${{ table.settings.smallBlind }}</strong></span>
            </strong>
        </p>
        <p>${Locale.players}: <strong><span id="balance"><strong>{{table.players.length}}/{{ table.settings.maxPlayers }}</strong></span>
            </strong>
        </p>
        </span>
    </div>
    <div class="poker-play" v-if="table.settings.maxPlayers >= table.players.length + 1 && wallet > table.settings.smallBlind * 2">
        <button class="mdc-button orange-glow mdc-button--raised" v-on:click="joinTable()">
            <div class="mdc-button__ripple"></div>
            <i class="material-icons mdc-button__icon" aria-hidden="true">play_circle</i>
            <span class="mdc-button__label">${Locale.joinTable}</span>
        </button>
    </div>
    <div class="poker-play" v-if="table.settings.maxPlayers >= table.players.length + 1 && wallet < table.settings.smallBlind * 2">
        <p>${Locale.notEnoughMoney}</p>
    </div>
    <div class="poker-play" v-if="table.settings.maxPlayers < table.players.length + 1 && wallet >= table.settings.smallBlind * 2">
        <p>${Locale.tableIsFull}</p>
    </div>
</div>
<div class="poker-container" v-if="player.id == 0 && joined">
    <div class="loader"></div>
</div>
<div class="poker-container" v-if="player.id != 0 && joined">
    <div class="tableTitle"><strong>{{ table.settings.name }}</strong></div>
    <div class="tableMessage">{{ getStateMessage() }}</div>
    <div v-for="(play, index) in table.players" :style="table.game.activePlayer == play.id ? 'box-shadow: 0px 0px 10px orange !important;' : ''" :class="'playerContainer playerContainer' + (1 + index)">
        <div>
            <img class="playerCard" v-for="card in play.cards" :src="'img/' + card + '.png'"></img>
        </div>
        <div class="playerNameContainer" :style="play.id == player.id ? 'color: orange;' : ''">{{ play.name }}</div>
        <div class="playerState">{{ getPStateMessage(play) }}</div>
    </div>
    <div class="cardContainer">
        <img class="tableCard" v-for="card in table.game.cards" :src="'img/' + card + '.png'"></img>
    </div>
    <div class="tablePot">${Locale.totalPot}: <strong>\${{ table.game.pot }}</strong></div>
    <div class="controlsTitle">${Locale.yourWallet}: <strong>\${{ wallet }}</strong></div>
    <div class="controls">
        <div class="controlButtons" v-if="!rising">
            <button v-if="table.game.state == 0 && findMyPlayer().state == -1" class="controlButton mdc-button green-glow mdc-button--raised" v-on:click="action('ready', 0)">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">check</i>
                <span class="mdc-button__label">${Locale.ready}</span>
            </button>
            <button v-if="table.game.state == 0 && findMyPlayer().state == 0" class="controlButton mdc-button red-glow mdc-button--raised" v-on:click="action('ready', -1)">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">cancel</i>
                <span class="mdc-button__label">${Locale.notReady}</span>
            </button>
            <button v-if="table.game.state == 1 && (table.game.call - findMyPlayer().bet == 0 || wallet <= 0)" :disabled="!isMyTurn()" class="controlButton mdc-button green-glow mdc-button--raised" v-on:click="action('check')">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">check</i>
                <span class="mdc-button__label">${Locale.check}</span>
            </button>
            <button v-if="table.game.state == 1 && table.game.call - findMyPlayer().bet > 0 && wallet > 0" :disabled="!isMyTurn()" class="controlButton mdc-button green-glow mdc-button--raised" v-on:click="action('call')">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">check</i>
                <span class="mdc-button__label">${Locale.call} \${{ table.game.call - findMyPlayer().bet }}</span>
            </button>
            <button v-if="table.game.state == 1 && wallet > 0" :disabled="!isMyTurn()" class="controlButton mdc-button orange-glow mdc-button--raised" v-on:click="rising = true">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">arrow_drop_up</i>
                <span class="mdc-button__label">${Locale.raise}</span>
            </button>
            <button v-if="table.game.state == 1" :disabled="!isMyTurn()" class="controlButton mdc-button red-glow mdc-button--raised" v-on:click="action('fold')">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">cancel</i>
                <span class="mdc-button__label">${Locale.fold}</span>
            </button>
        </div>
        <div class="riseContainer" v-if="rising">
            <input class="riseInput" type="number" value="1"  min="1" :max="wallet" v-model="rise">
            <button class="controlButton mdc-button green-glow mdc-button--raised" v-on:click="action('raise', rise)">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">check</i>
                <span class="mdc-button__label">${Locale.confirm}</span>
            </button>
            <button class="controlButton mdc-button red-glow mdc-button--raised" v-on:click="rising = false">
                <div class="mdc-button__ripple"></div>
                <i class="material-icons mdc-button__icon" aria-hidden="true">cancel</i>
                <span class="mdc-button__label">${Locale.cancel}</span>
            </button>
        </div>
        <button class="mdc-button red-glow mdc-button--raised" v-on:click="leaveTable()" style="position: absolute; top: 20%; right: 2%;">
            <div class="mdc-button__ripple"></div>
            <i class="material-icons mdc-button__icon" aria-hidden="true">exit_to_app</i>
            <span class="mdc-button__label">${Locale.leaveTable}</span>
        </button>
    </div>
</div>
<div class="join-container" v-if="editing">
    <button style="left: 44.5%;" class="mdc-button red-glow mdc-button--raised" v-on:click="openEditUI(false)">
        <div class="mdc-button__ripple"></div>
        <span class="mdc-button__label">X</span>
    </button>
    <div class="poker-welcome">
        <p><strong>${Locale.tableName}</strong></p>
        <input class="settingInput" type="text" v-model="table.settings.name" placeholder="${Locale.tableName}">
        <p><strong>${Locale.maxPlayers}</strong></p>
        <input class="settingInput" type="number" min="2" max="10" v-model="table.settings.maxPlayers" placeholder="${Locale.maxPlayers}">
        <p><strong>${Locale.smallBlind}</strong></p>
        <input class="settingInput" type="number" min="1" v-model="table.settings.smallBlind" placeholder="${Locale.smallBlind}">
    </div>
    <br>
    <button class="mdc-button green-glow mdc-button--raised" v-on:click="updateTable()">
        <div class="mdc-button__ripple"></div>
        <i class="material-icons mdc-button__icon" aria-hidden="true">play_circle</i>
        <span class="mdc-button__label">${Locale.saveTable}</span>
    </button>
    <br>
    <button class="mdc-button red-glow mdc-button--raised" v-on:click="deleteTable()">
        <div class="mdc-button__ripple"></div>
        <i class="material-icons mdc-button__icon" aria-hidden="true">delete</i>
        <span class="mdc-button__label">${Locale.deleteTable}</span>
    </button>
</div>
</div>`