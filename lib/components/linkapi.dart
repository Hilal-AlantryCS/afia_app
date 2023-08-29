const String linkServerName = "http://154.62.109.112:8000/api";
const String linkPhoto = "http://154.62.109.112:8000";

//?Auth

const String linkSignUp = "$linkServerName/auth/signup/";
const String linkLogin = "$linkServerName/auth/login/";

//?appointment

const String linkGetDoctors =
    "$linkServerName/profile/doctors/?specialization_id=";
const String linkGetAppointment = "$linkServerName/appointment/appointments/";
const String linkPostAppointment =
    "$linkServerName/appointment/patient-create-appointment/";

const String linkCancelAppointment =
    "$linkServerName/appointment/patient-cancel-appointment/";
const String linkRequestAppointment =
    "$linkServerName/appointment/patient-request-appointment/";
const String linkConfirmAppointment =
    "$linkServerName/appointment/patient-confirm-appointment/";
