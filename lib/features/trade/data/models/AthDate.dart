class AthDate {
  AthDate({
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

  AthDate.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aed'] = aed;
    map['ars'] = ars;
    map['aud'] = aud;
    map['bch'] = bch;
    map['bdt'] = bdt;
    map['bhd'] = bhd;
    map['bmd'] = bmd;
    map['bnb'] = bnb;
    map['brl'] = brl;
    map['btc'] = btc;
    map['cad'] = cad;
    map['chf'] = chf;
    map['clp'] = clp;
    map['cny'] = cny;
    map['czk'] = czk;
    map['dkk'] = dkk;
    map['dot'] = dot;
    map['eos'] = eos;
    map['eth'] = eth;
    map['eur'] = eur;
    map['gbp'] = gbp;
    map['gel'] = gel;
    map['hkd'] = hkd;
    map['huf'] = huf;
    map['idr'] = idr;
    map['ils'] = ils;
    map['inr'] = inr;
    map['jpy'] = jpy;
    map['krw'] = krw;
    map['kwd'] = kwd;
    map['lkr'] = lkr;
    map['ltc'] = ltc;
    map['mmk'] = mmk;
    map['mxn'] = mxn;
    map['myr'] = myr;
    map['ngn'] = ngn;
    map['nok'] = nok;
    map['nzd'] = nzd;
    map['php'] = php;
    map['pkr'] = pkr;
    map['pln'] = pln;
    map['rub'] = rub;
    map['sar'] = sar;
    map['sek'] = sek;
    map['sgd'] = sgd;
    map['thb'] = thb;
    map['try'] = tryValue;
    map['twd'] = twd;
    map['uah'] = uah;
    map['usd'] = usd;
    map['vef'] = vef;
    map['vnd'] = vnd;
    map['xag'] = xag;
    map['xau'] = xau;
    map['xdr'] = xdr;
    map['xlm'] = xlm;
    map['xrp'] = xrp;
    map['yfi'] = yfi;
    map['zar'] = zar;
    map['bits'] = bits;
    map['link'] = link;
    map['sats'] = sats;
    return map;
  }
}