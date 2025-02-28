class AtlDate {
  String? aed;
  String? ars;
  String? aud;
  String? bch;
  String? bdt;
  String? bhd;
  String? bmd;
  String? bnb;
  String? brl;
  String? btc;
  String? cad;
  String? chf;
  String? clp;
  String? cny;
  String? czk;
  String? dkk;
  String? dot;
  String? eos;
  String? eth;
  String? eur;
  String? gbp;
  String? gel;
  String? hkd;
  String? huf;
  String? idr;
  String? ils;
  String? inr;
  String? jpy;
  String? krw;
  String? kwd;
  String? lkr;
  String? ltc;
  String? mmk;
  String? mxn;
  String? myr;
  String? ngn;
  String? nok;
  String? nzd;
  String? php;
  String? pkr;
  String? pln;
  String? rub;
  String? sar;
  String? sek;
  String? sgd;
  String? thb;
  String? tryValue;
  String? twd;
  String? uah;
  String? usd;
  String? vef;
  String? vnd;
  String? xag;
  String? xau;
  String? xdr;
  String? xlm;
  String? xrp;
  String? yfi;
  String? zar;
  String? bits;
  String? link;
  String? sats;

  AtlDate({
    this.aed,
    this.ars,
    this.aud,
    this.bch,
    this.bdt,
    this.bhd,
    this.bmd,
    this.bnb,
    this.brl,
    this.btc,
    this.cad,
    this.chf,
    this.clp,
    this.cny,
    this.czk,
    this.dkk,
    this.dot,
    this.eos,
    this.eth,
    this.eur,
    this.gbp,
    this.gel,
    this.hkd,
    this.huf,
    this.idr,
    this.ils,
    this.inr,
    this.jpy,
    this.krw,
    this.kwd,
    this.lkr,
    this.ltc,
    this.mmk,
    this.mxn,
    this.myr,
    this.ngn,
    this.nok,
    this.nzd,
    this.php,
    this.pkr,
    this.pln,
    this.rub,
    this.sar,
    this.sek,
    this.sgd,
    this.thb,
    this.tryValue,
    this.twd,
    this.uah,
    this.usd,
    this.vef,
    this.vnd,
    this.xag,
    this.xau,
    this.xdr,
    this.xlm,
    this.xrp,
    this.yfi,
    this.zar,
    this.bits,
    this.link,
    this.sats,
  });

  AtlDate.fromJson(Map<String, dynamic> json) {
    aed = json['aed'];
    ars = json['ars'];
    aud = json['aud'];
    bch = json['bch'];
    bdt = json['bdt'];
    bhd = json['bhd'];
    bmd = json['bmd'];
    bnb = json['bnb'];
    brl = json['brl'];
    btc = json['btc'];
    cad = json['cad'];
    chf = json['chf'];
    clp = json['clp'];
    cny = json['cny'];
    czk = json['czk'];
    dkk = json['dkk'];
    dot = json['dot'];
    eos = json['eos'];
    eth = json['eth'];
    eur = json['eur'];
    gbp = json['gbp'];
    gel = json['gel'];
    hkd = json['hkd'];
    huf = json['huf'];
    idr = json['idr'];
    ils = json['ils'];
    inr = json['inr'];
    jpy = json['jpy'];
    krw = json['krw'];
    kwd = json['kwd'];
    lkr = json['lkr'];
    ltc = json['ltc'];
    mmk = json['mmk'];
    mxn = json['mxn'];
    myr = json['myr'];
    ngn = json['ngn'];
    nok = json['nok'];
    nzd = json['nzd'];
    php = json['php'];
    pkr = json['pkr'];
    pln = json['pln'];
    rub = json['rub'];
    sar = json['sar'];
    sek = json['sek'];
    sgd = json['sgd'];
    thb = json['thb'];
    tryValue = json['try'];
    twd = json['twd'];
    uah = json['uah'];
    usd = json['usd'];
    vef = json['vef'];
    vnd = json['vnd'];
    xag = json['xag'];
    xau = json['xau'];
    xdr = json['xdr'];
    xlm = json['xlm'];
    xrp = json['xrp'];
    yfi = json['yfi'];
    zar = json['zar'];
    bits = json['bits'];
    link = json['link'];
    sats = json['sats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aed'] = aed;
    data['ars'] = ars;
    data['aud'] = aud;
    data['bch'] = bch;
    data['bdt'] = bdt;
    data['bhd'] = bhd;
    data['bmd'] = bmd;
    data['bnb'] = bnb;
    data['brl'] = brl;
    data['btc'] = btc;
    data['cad'] = cad;
    data['chf'] = chf;
    data['clp'] = clp;
    data['cny'] = cny;
    data['czk'] = czk;
    data['dkk'] = dkk;
    data['dot'] = dot;
    data['eos'] = eos;
    data['eth'] = eth;
    data['eur'] = eur;
    data['gbp'] = gbp;
    data['gel'] = gel;
    data['hkd'] = hkd;
    data['huf'] = huf;
    data['idr'] = idr;
    data['ils'] = ils;
    data['inr'] = inr;
    data['jpy'] = jpy;
    data['krw'] = krw;
    data['kwd'] = kwd;
    data['lkr'] = lkr;
    data['ltc'] = ltc;
    data['mmk'] = mmk;
    data['mxn'] = mxn;
    data['myr'] = myr;
    data['ngn'] = ngn;
    data['nok'] = nok;
    data['nzd'] = nzd;
    data['php'] = php;
    data['pkr'] = pkr;
    data['pln'] = pln;
    data['rub'] = rub;
    data['sar'] = sar;
    data['sek'] = sek;
    data['sgd'] = sgd;
    data['thb'] = thb;
    data['try'] = tryValue;
    data['twd'] = twd;
    data['uah'] = uah;
    data['usd'] = usd;
    data['vef'] = vef;
    data['vnd'] = vnd;
    data['xag'] = xag;
    data['xau'] = xau;
    data['xdr'] = xdr;
    data['xlm'] = xlm;
    data['xrp'] = xrp;
    data['yfi'] = yfi;
    data['zar'] = zar;
    data['bits'] = bits;
    data['link'] = link;
    data['sats'] = sats;
    return data;
  }
}